//
//  CommentsViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

class CommentsViewModel: ObservableObject{
    let post: Post
    @Published var comments = [Comment]()
    
    init(post: Post) {
        self.post = post
        fetchComment()
    }
    
    func uploadComment(comment: String){
        guard let postID = post.id else{ return }
        guard let user = AuthViewModel.shared.currentUser else{ return }
        guard let userID = user.id else{ return }
        
        let data: [String: Any] = [
            "comment": comment,
            "uid": userID,
            "timestamp": Timestamp(date: Date()),
            "postOwnerID": post.ownerUID,
            "username": user.username,
            "profileImageURL": user.profileImageURL as Any
        ]
        
        Firestore.firestore().collection("posts").document(postID).collection("post-comments").addDocument(data: data){
            error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .comment, post: self.post)
        }
    }
    
    func fetchComment() {
        guard let postID = post.id else{ return }
        
        Firestore.firestore().collection("posts").document(postID).collection("post-comments").order(by: "timestamp", descending: true).addSnapshotListener { (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let documentChanges = snap?.documentChanges.filter({$0.type == .added}) else{ return }
            self.comments.append(contentsOf: documentChanges.compactMap{
                try? $0.document.data(as: Comment.self)
            })
        }
    }
}

