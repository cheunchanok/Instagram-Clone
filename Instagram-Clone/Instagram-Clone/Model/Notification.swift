//
//  Notification.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Notification: Decodable, Identifiable {
    @DocumentID var id: String?
    var postID: String?
    var username: String?
    var profileImageURL: String?
    var timestamp: Timestamp
    var uid: String
    var type: NotificationType
    
    var post: Post?
    var user: User?
    var didFollow: Bool? = false
}

enum NotificationType: Int, Decodable {
    case follow
    case like
    case comment
    
    var notificationMessage: String {
        switch self {
        case .follow:
            return "started following you."
        case .like:
            return "loke one of your posts."
        case .comment:
            return "commented on one of your posts."
        }
    }
}

