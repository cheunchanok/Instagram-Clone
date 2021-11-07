//
//  ProfileView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 4/11/2564 BE.
//

import SwiftUI

struct ProfileView: View {
    @State var user: User
    
    var body: some View {
        ScrollView{
            VStack(spacing: 32){
                ProfileHeaderView(viewModel: ProfileViewModel(user: user))
                .padding()
                
                if let currentProfileID = user.id{
                    PostGridView(config: .profile(currentProfileID))
                }
            }
        }
    }
}

