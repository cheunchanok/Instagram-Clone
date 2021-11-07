//
//  MessagesViewModel.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 8/11/2564 BE.
//

import SwiftUI
import Firebase

class MessagesViewModel: ObservableObject{
    let user: User
    @Published var messages = [Message]()
    
    init(user: User){
        self.user = user
        fetchMessage()
    }
    
    func fetchMessage(){
        guard let senderID = AuthViewModel.shared.userSession?.uid else{ return }
        guard let recieverID = user.id else{ return }
        
        Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(recieverID).collection("messages").order(by: "timestamp", descending: false).addSnapshotListener{(snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documentChanges = snap?.documentChanges.filter({$0.type == .added}) else{ return }
            self.messages.append(contentsOf: documentChanges.compactMap{
                try? $0.document.data(as: Message.self)
            })
        }
    }
    
    func sendMessage(message: String){
        guard let sender = AuthViewModel.shared.currentUser else{ return }
        guard let senderID = sender.id else { return }
        guard let receiverID = user.id else { return }
        
        let data: [String: Any] = [
            "senderID": senderID,
            "receiverID": receiverID,
            "message": message,
            "timestamp": Timestamp(date: Date()),
            "ownerImageURL": sender.profileImageURL as Any
        ]
        
        Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(receiverID).collection("messages").addDocument(data: data){ error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            Firestore.firestore().collection("messages").document(receiverID).collection("user-messages").document(senderID).collection("messages").addDocument(data: data){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
}
