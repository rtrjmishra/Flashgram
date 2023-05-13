//
//  PostImageView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 08/04/23.
//

import SwiftUI

struct PostImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var captionText: String = ""
    @Binding var imageSelected: UIImage
    
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    @AppStorage(UserDefaultsFields.displayName) var currentDisplayName: String?
    
    @State var showAlert: Bool = false
    @State var postUploadedSuccesfully: Bool = false
    
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
                
                TextField("Add your caption here... ", text: $captionText)
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
        .alert(isPresented: $showAlert) { () -> Alert in
            getAlert()
        }
    }
    
    //MARK: - Functions
    func postPicture() {
        guard let currentUserID, let currentDisplayName else {
            print("Error getting userid and display name in app.")
            return
        }
        
        DataService.shared.uploadPost(image: imageSelected, caption: captionText, displayName: currentDisplayName, userID: currentUserID) { success in
            self.postUploadedSuccesfully = success
            self.showAlert.toggle()
        }
    }
    
    func getAlert() -> Alert {
        if postUploadedSuccesfully {
            return Alert(title: Text("Successfully Uploaded Post🎉"),
                         dismissButton: .default(Text("OK"), action: { self.presentationMode.wrappedValue.dismiss() }))
            
        } else {
            return Alert(title: Text("Error uploading post🤯"))
        }
    }
    
}

struct PostImageView_Previews: PreviewProvider {
    static var previews: some View {
        PostImageView(imageSelected: .constant(UIImage(named: "image1")!))
    }
}
