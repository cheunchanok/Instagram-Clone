//
//  CommentInputView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct CommentInputView: View {
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.8)
            
            HStack{
                TextField("Comment...", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action){
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

