//
//  TextArea.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text // _text = Binding
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            if text.isEmpty{
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            
            TextEditor(text: $text)
                .padding(4)
        }
        .font(.body)
    }
}


