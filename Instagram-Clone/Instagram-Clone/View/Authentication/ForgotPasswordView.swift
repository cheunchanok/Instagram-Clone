//
//  ForgotPasswordView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 7/11/2564 BE.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var email: String
   
    init(email: Binding<String>){
        _email = email
    }
    
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
                }
                
                HStack{
                    Spacer()
                    
                    NavigationLink(
                        destination: SinginView().navigationBarHidden(true),
                        label: {
                            Text("Go Back")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.gray)
                                .padding(.top)
                                .padding(.trailing, 28)
                           
                        }
                    )
                }
                .padding(.horizontal, 24)
                
                Button{
                    
                } label:{
                    Text("Reset Password")
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

