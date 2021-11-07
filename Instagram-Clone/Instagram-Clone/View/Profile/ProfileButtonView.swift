//
//  ProfileButtonView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct ProfileButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var editProfileShow = false
    
    var didFollow: Bool {
        viewModel.user.didFollow ?? false
    }
    
    var body: some View {
        if viewModel.user.isCurrentUser{
            Button{
                editProfileShow.toggle()
            } label: {
                Text("Edit Profile")
                    .font(.system(size:14, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }.sheet(isPresented: $editProfileShow, onDismiss: nil){
                EditProfileView(user: $viewModel.user)
            }
        }else{
            HStack(spacing: 16){
                Button{
                    didFollow ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(didFollow ?  "Following" : "Follow")
                        .font(.system(size:14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(didFollow ?  .black : .white)
                        .background(didFollow ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: didFollow ? 1 : 0)
                        )
                    }
                .cornerRadius(3)
                if let user = viewModel.user{
                    NavigationLink(destination: MessageChatView(user: user)){
                        Text("Message")
                            .font(.system(size:14, weight: .semibold))
                            .frame(width: 172, height: 32)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
            }
        }
    }
}


