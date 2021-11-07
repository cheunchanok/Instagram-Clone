//
//  UserService.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

class UserService{
    static func follow(uid: String, completion: (@escaping (Error?) -> Void)){
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("following").document(currentUID).collection("user-following").document(uid).setData([:]){ error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(uid).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: (@escaping (Error?) -> Void)){
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("following").document(currentUID).collection("user-following").document(uid).delete(){ error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(uid).delete(completion: completion)
        }
    }
        
    static func checkFollow(uid: String, completion: (@escaping (Bool) -> Void)){
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("following").document(currentUID).collection("user-following").document(uid).getDocument{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let didFollow = snap?.exists else { return }
            
            completion(didFollow)
        }
    }
}

