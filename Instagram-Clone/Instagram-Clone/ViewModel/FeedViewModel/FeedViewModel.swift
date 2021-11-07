//
//  FeedViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class FeedViewModel: ObservableObject{
    @Published var posts = [Post]()
    
    init(){
        fecthPosts()
    }
    
    func fecthPosts(){
        Firestore.firestore().collection("posts").getDocuments{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.posts = documents.compactMap{ try? $0.data(as: Post.self)}
        }
    }
    
}
