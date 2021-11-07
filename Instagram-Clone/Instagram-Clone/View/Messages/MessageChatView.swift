//
//  MessageChatView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct MessageChatView: View {
    @State var message = ""
    @ObservedObject var viewModel: MessagesViewModel
    
    init(user: User){
        viewModel = MessagesViewModel(user: user)
    }
    
    @State var scrolled = false
    
    var body: some View {
        VStack{
            ScrollViewReader{ reader in
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.messages){ message in
                            MessageRowView(message: message)
                                .onAppear{
                                    if message.id == viewModel.messages.last?.id && !scrolled{
                                        reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                                    }
                                }
                        }
                        .onChange(of: viewModel.messages){_ in
                            reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
            MessageInputView(message: $message, action: sendMessage)
        }
    }
    func sendMessage() {
        viewModel.sendMessage(message: message)
        message = ""
    }
}


