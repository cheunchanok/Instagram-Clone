//
//  SearchViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers(){
        Firestore.firestore().collection("users").getDocuments{ (snap, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let documents =  snap?.documents else { return }
            self.users = documents.compactMap{  try? $0.data(as: User.self) }
        }
    }
    

    func filterUsers(withText input: String) -> [User]{
        let lowercaseInput = input.lowercased() // ทำเป็น lowercase ให้หมด
        return users.filter{ $0.fullname.lowercased().contains(lowercaseInput) || $0.username.lowercased().contains(lowercaseInput)}
        
    }
}

