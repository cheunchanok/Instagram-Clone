//
//  NontificationCell.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationsCellViewModel
    
    var didFollow: Bool {
        viewModel.notification.didFollow ?? false
    }
    
    var body: some View {
        HStack{
            if let user = viewModel.notification.user{
                NavigationLink(destination: ProfileView(user: user)) {
                    if let imageURL = viewModel.notification.profileImageURL{
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 40, height: 40)
                            .clipShape(Circle())
                    }else{
                        Image(systemName: "person.crop.circle.fill")
                            .resizeTo(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    
                    Text(viewModel.notification.username!)
                        .font(.system(size: 14, weight: .semibold))
                    +
                        Text(viewModel.notification.type.notificationMessage)
                    .font(.system(size: 15))
                    +
                        Text(viewModel.timestamp)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
            }
            
            Spacer()
            
            if viewModel.notification.type == .follow{
                Button{
                    didFollow ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(didFollow ? "Following" : "Follow Back")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(didFollow ? .black : .white)
                        .background(didFollow ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: didFollow ? 1 : 0)
                        )
                } .cornerRadius(3)
            }else if let post = viewModel.notification.post{
                NavigationLink(destination: FeedCell(viewModel: FeedCellViewModel(post:post))){
                    KFImage(URL(string: post.imageURL))
                        .resizeTo(width: 40, height: 40)
                        .clipped()
                }
            }
        }
        .padding(.horizontal)
    }
}

//struct NotificationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCell()
//    }
//}
