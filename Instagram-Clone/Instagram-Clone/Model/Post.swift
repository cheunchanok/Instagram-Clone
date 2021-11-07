//
//  Post.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Post: Decodable, Identifiable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    let imageURL: String
    let ownerUID: String
    var ownerImageURL: String?
    let ownerUsername: String
    
    // ทำเป็น optional เพราะว่าfield พวกนี้ไม่ได้อยู่ใน firestore ถ้ามันเปลี่ยนกลับมาแล้วไม่มีค่า defaulr มันจะ error
    var user: User?
    var didLike: Bool? = false
}
