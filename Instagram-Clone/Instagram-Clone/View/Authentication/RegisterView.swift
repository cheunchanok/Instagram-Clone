//
//  RegisterView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var username = ""
    @State var fullname = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                Image("instagram-text-logo")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .foregroundColor(.black)
                
                VStack(spacing: -16){
                    CustomTextField(placeholder: Text("Email"), text: $email, imageName: "envelope")
                        .padding()
                        .padding(.horizontal, 32)
                    
                    CustomTextField(placeholder: Text("Username"), text: $username, imageName: "person")
                        .padding()
                        .padding(.horizontal, 32)
                    
                    CustomTextField(placeholder: Text("Fullname"), text: $fullname, imageName: "person")
                        .padding()
                        .padding(.horizontal, 32)
                    
                    CustomSecureField(placeholder: Text("Password"), text: $password)
                        .padding()
                        .padding(.horizontal, 32)
                }
                
                Button{
                    viewModel.register(withEmail: email, password: password, username: username, fullname: fullname)
                } label:{
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                }
                
                Spacer()
                
                NavigationLink(
                    destination: SinginView().navigationBarHidden(true),
                    label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.system(size: 14, weight: .semibold))
                            
                            Text("Sing In")
                                .font(.system(size: 14))
                        }
                    }
                )
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthViewModel.shared)
    }
}

