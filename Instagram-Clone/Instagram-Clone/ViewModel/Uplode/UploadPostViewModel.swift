//
//  UploadPostViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject{
    
    func uploadPost(image: UIImage, caption: String){
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .post){ imageURL in
            guard let uid = user.id else { return }
            
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageURL": imageURL,
                "ownerUID": uid,
                "ownerUsername": user.username
            ] as [String: Any]
            
            Firestore.firestore().collection("posts").addDocument(data: data){ error in
                if let error = error{
                    print(error)
                    return
                }
            }
        }
    }
}

