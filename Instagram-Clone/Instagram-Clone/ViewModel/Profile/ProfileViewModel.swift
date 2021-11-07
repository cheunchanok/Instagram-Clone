//
//  ProfileViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject{
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkFollow()
        checkStats()
    }
    // เปลี่ยนรูป profile
    func changeProfileImage(image: UIImage){
        ImageUploader.uploadImage(image: image, type: .profile){ imageURL in
            guard let uid = self.user.id else { return }
            Firestore.firestore().collection("users").document(uid).updateData([
                "profileImageURL": imageURL
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.user.updateProfileImageURL(url: imageURL)
                
            }
        }
    }
    
    func follow(){
        if let didFollow = user.didFollow, didFollow{
            return
        }
        guard let uid = user.id else { return }
        UserService.follow(uid: uid){error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            NotificationsViewModel.sendNotification(withUID: uid, type: .follow)
            self.user.didFollow = true
        }
    }
    
    func unfollow(){
        if let didFollow = user.didFollow, !didFollow{
            return
        }
        guard let uid = user.id else { return }
        UserService.unfollow(uid: uid){ error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            self.user.didFollow = false
        }
    }
        
    func checkFollow(){
        guard let uid = user.id else { return }
        UserService.checkFollow(uid: uid){ didFollow in
            self.user.didFollow = didFollow
        }
    }
    
    func checkStats(){
        guard let uid = user.id else { return }
        
        Firestore.firestore().collection("followers").document(uid).collection("user-followers").getDocuments{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let followers = snap?.documents.count else { return }
            
            Firestore.firestore().collection("following").document(uid).collection("user-following").getDocuments{ (snap, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let following = snap?.documents.count else { return }
                
                Firestore.firestore().collection("posts").whereField("ownerUID", isEqualTo: uid).getDocuments{ (snap, error) in
                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                    guard let posts = snap?.documents.count else { return }
                    // สร้างขึ้นมาใหม่
                    self.user.stats = UserStatsData(following: following, followers: followers, posts: posts)
                }
            }
        }
    }
}

