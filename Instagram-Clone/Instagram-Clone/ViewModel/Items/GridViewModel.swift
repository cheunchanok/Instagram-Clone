//
//  GridViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

enum PostGridConfig{
    case explore
    case profile(String)
}

class GrideViewModel: ObservableObject{
    @Published var posts = [Post]()
    let config: PostGridConfig
    
    init(config: PostGridConfig){
        self.config = config
        fetchPosts()
    }
    
    func fetchPosts(){
        switch config {
        case .explore:
            fecthPostsExplorePage()
        case .profile(let uid):
            fecthPostsProfile(widthUID: uid)
        }
    }
    
    func fecthPostsExplorePage(){
        Firestore.firestore().collection("posts").getDocuments{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.posts = documents.compactMap{ try? $0.data(as: Post.self)}
        }
    }
    
    func fecthPostsProfile(widthUID uid: String){
        Firestore.firestore().collection("posts").whereField("ownerUID", isEqualTo: uid).getDocuments{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.posts = documents.compactMap{ try? $0.data(as: Post.self)}
        }
    }
}
