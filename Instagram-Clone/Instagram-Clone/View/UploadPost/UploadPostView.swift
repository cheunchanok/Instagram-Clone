//
//  UploadPostView.swift
//  Instagram-Clone
//
//  Created by Cheunchanok Phewkleang on 4/11/2564 BE.
//

import SwiftUI

struct UploadPostView: View {
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        if postImage == nil{
            Button(action:{
                imagePickerPresented.toggle() // ถ้ากดให้เลือกรูปได้
            }){
                Image(systemName: "plus.circle")
                    .resizeTo(width: 180, height: 180)
                    .padding(.top)
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $imagePickerPresented){
                loadImage() // ถ้าเป็น true จะแสดง ImagePicker
            }content: {
                ImagePicker(image: $selectedImage)
            }
        }
        else if let image = postImage{
            VStack{
                HStack(alignment: .top){
                    image
                        .resizeTo(width: 96, height: 96)
                        .clipped()
                    
                    TextArea("Enter your caption...", text: $captionText)
                }
                .padding()
                
                Button{
                    if let image = selectedImage{
                        viewModel.uploadPost(image: image, caption: captionText)
                        captionText = ""
                        postImage = nil
                    }
                } label: {
                    Text("Share")
                        .font(.system(size:16, weight: .semibold))
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    func loadImage(){
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}

