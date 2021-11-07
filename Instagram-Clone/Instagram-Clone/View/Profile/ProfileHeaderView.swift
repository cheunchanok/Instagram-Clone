//
//  ProfileHeader.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State var selectedImage: UIImage?
    @State var imagePickerPresented = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    Button{
                        imagePickerPresented.toggle()
                    } label: {
                        if let imageURL = viewModel.user.profileImageURL{
                            KFImage(URL(string: imageURL)) // โหลดรูปจาก url
                                .resizable()
                                .scaledToFill()
                                .frame(width:80, height: 80)
                                .clipShape(Circle())
                                .padding(.leading, 16)
                        }else{
                            Image(systemName: "person.crop.circle.fill")
                                .resizeTo(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.leading, 16)
                            }
                        }
                        .sheet(isPresented: $imagePickerPresented){
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                    }
                }
               
                HStack(spacing: 16){
                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Posts")
                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                    UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
                }
            }
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top, 10)
            }
            
            HStack{
                Spacer()
                ProfileButtonView(viewModel: viewModel)
                Spacer()
            }
            .padding()
        }
    }
    
    func loadImage(){
        guard let selectedImage = selectedImage else { return }
        viewModel.changeProfileImage(image: selectedImage)
    }
}


