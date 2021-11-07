//
//  SearchBar.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String // Binding เพราะรับค่าจากข้างนอกมา
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack{
            TextField("Search...",text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    })
            
            Button(action: {
                isEditing = false
                text = ""
                UIApplication.shared.endEditing()
            }){
                Text("Cancle")
                    .foregroundColor(.black)
            }
            .padding(.trailing, 8)
            .transition(.move(edge: .trailing))
            .animation(.default)
        }
        .onTapGesture {
            isEditing = true
        }
    }
}

