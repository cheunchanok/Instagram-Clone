//
//  NotificationView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 4/11/2564 BE.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.notifications){ notification in
                    NotificationCell(viewModel: NotificationsCellViewModel(notification: notification))
                        .padding(.top)
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
