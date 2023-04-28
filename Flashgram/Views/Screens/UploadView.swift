//
//  UploadView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI
import UIKit

struct UploadView: View {
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "uploadPageLogo")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Button {
                    sourceType = .camera
                    showImagePicker.toggle()
                } label: {
                    Text("TAKE PHOTO")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.Flash.yellowColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.Flash.purpleColor)
                
                Button {
                    sourceType = .photoLibrary
                    showImagePicker.toggle()
                } label: {
                    Text("IMPORT PHOTO")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.Flash.purpleColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.Flash.yellowColor)
            }
            .sheet(isPresented: $showImagePicker, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    showPostImageView.toggle()
                })
            }, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
            })
            
            Image("uploadPageLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
                .shadow(radius: 20)
                .fullScreenCover(isPresented: $showPostImageView) {
                    PostImageView(imageSelected: $imageSelected)
                }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
