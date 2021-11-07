//
//  EditProfileViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 8/11/2564 BE.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject{
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func saveBio(bio: String){
        guard let userID = user.id else { return }
        
        Firestore.firestore().collection("users").document(userID).updateData(["bio": bio]){ error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            self.user.bio = bio
            self.uploadComplete = true
        }
    }
}
