//
//  MessageBubble.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 8/11/2564 BE.
//

import SwiftUI

struct MessageBubble: Shape {
    var ownAccount: Bool
    
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, ownAccount ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        return Path(path.cgPath)
    }
}

