//
//  PostImageView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 08/04/23.
//

import SwiftUI

struct PostImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    @Binding var imageSelected: UIImage
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                        .accentColor(.primary)
                }
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(12)
                    .clipped()
                    .padding(.bottom)
                
                TextField("Add your caption here... ", text: $text)
                    .padding()
                    .frame(height: 100, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.beigeColor)
                    .cornerRadius(12)
                    .font(.headline)
                    .padding(.horizontal)
                    .autocapitalization(.sentences)
                    .padding(.bottom)
                
                Button {
                    postPicture()
                } label: {
                    Text("Post Picture!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.Flash.purpleColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .accentColor(Color.Flash.yellowColor)
            }
        }
    }
    
    //MARK: - Functions
    
    func postPicture() {
        print("Post Picture to DB!")
    }
    
}

struct PostImageView_Previews: PreviewProvider {
    static var previews: some View {
        PostImageView(imageSelected: .constant(UIImage(named: "image1")!))
    }
}
