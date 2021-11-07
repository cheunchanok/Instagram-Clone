//
//  FeedView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 4/11/2564 BE.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.posts){post in
                    FeedCell(viewModel: FeedCellViewModel(post: post))
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
