//
//  FeedCell.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 4/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    var didLike: Bool{ // เช็คว่ามีค่ามั้ย ถ้าไม่มี จะรีเทิน false
        viewModel.post.didLike ?? false
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if let user = viewModel.post.user{
                NavigationLink(destination: ProfileView(user: user)){
                    HStack{
                        if let imageURL = viewModel.post.ownerImageURL{
                            KFImage(URL(string: imageURL))
                                .resizeTo(width: 36, height: 36)
                                .clipShape(Circle())
                        } else{
                            Image(systemName: "person.crop.circle.fill")
                                .resizeTo(width: 36, height: 36)
                                .clipShape(Circle())
                        }
                        
                        Text(viewModel.post.ownerUsername)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding([.leading, .bottom], 8)
                }
            }
            
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            HStack{
                Button{
                    didLike ? viewModel.unlike() : viewModel.like()
                } label:{
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizeTo(width: 20, height: 20)
                        .foregroundColor(didLike ? .red : .black)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                NavigationLink(destination: CommentsView(post: viewModel.post)){
                    Image(systemName: "bubble.right")
                        .resizeTo(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                Image(systemName: "paperplane")
                    .resizeTo(width: 20, height: 20)
                    .font(.system(size: 20))
                    .padding(4)
            }
            .padding(.leading,4)
            
            Text(viewModel.likeText)
                .font(.system(size:14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 0.5)
            
            HStack{
                Text(viewModel.post.ownerUsername)
                    .font(.system(size:14, weight: .semibold))
                +
                    Text(" \(viewModel.post.caption)")
                    .font(.system(size:14))
            }
            .padding(.horizontal, 8)
            
            Text(viewModel.timestamp)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        }
    }
}


