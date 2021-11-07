//
//  PostGridView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @ObservedObject var viewModel: GrideViewModel
    
    let items = [GridItem(), GridItem(), GridItem()] // รูปเป็น 3 column
    
    init(config: PostGridConfig){
        viewModel = GrideViewModel(config: config)
    }
    
    var body: some View {
        GeometryReader{ proxy in
            LazyVGrid(columns: items, spacing:2){
                ForEach(viewModel.posts){ post in
                    KFImage(URL(string: post.imageURL))
                        .resizeTo(width: proxy.size.width / 3, height: proxy.size.width / 3)
                        .clipped() 
                }
            }
        }
    }
}
