//
//  NotificationsCellViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

class NotificationsCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    init(notification: Notification){
        self.notification = notification
        fetchUser()
        fetchPost()
        checkFollow()
    }
    
    func fetchUser(){
        Firestore.firestore().collection("users").document(notification.uid).getDocument{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
           
            self.notification.user = try? snap?.data(as: User.self)
        }
    }
    
    func fetchPost() {
        guard let postID = notification.postID else { return }
        
        Firestore.firestore().collection("posts").document(postID).getDocument{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            self.notification.post = try? snap?.data(as: Post.self)
        }
    }
    
    func follow(){
        if let didFollow = notification.didFollow, didFollow{
            return
        }
        UserService.follow(uid: notification.uid){error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            NotificationsViewModel.sendNotification(withUID: self.notification.uid, type: .follow)
            self.notification.didFollow = true
        }
    }
    
    func unfollow(){
        if let didFollow = notification.didFollow, !didFollow{
            return
        }
        UserService.unfollow(uid: notification.uid){ error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            self.notification.didFollow = false
        }
    }
        
    func checkFollow(){
        UserService.checkFollow(uid: notification.uid){ didFollow in
            self.notification.didFollow = didFollow
        }
    }
    
    var timestamp: String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
}

