//
//  MainView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 4/11/2564 BE.
//

import SwiftUI

struct MainView: View {
    @State var user: User
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedIndex){
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(1)
                
                UploadPostView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                    .tag(2)

                
                NotificationView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "heart")
                    }
                    .tag(3)

                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                    }
                    .tag(4)
            }
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: logOutButton)
            .accentColor(.black)
        }
    }
    
    var logOutButton: some View{
        Button{
            AuthViewModel.shared.singOut()
        }
            label:{
                Text("Log Out")
                    .foregroundColor(.black)
            }
    }
    
    var tabTitle: String{
        switch selectedIndex{
        case 0: return "Feed"
        case 1: return "Search"
        case 2: return "Upload"
        case 3: return "Notification"
        case 4: return "Profile"
        default: return ""
        }
    }
}
