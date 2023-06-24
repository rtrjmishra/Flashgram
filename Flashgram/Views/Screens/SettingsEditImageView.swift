//
//  SettingsEditImageView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 27/04/23.
//

import SwiftUI

struct SettingsEditImageView: View {
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage //Image shown on this screen.
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType
    @Binding var profileImage: UIImage
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    @State var showSuccessAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(5)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.yellowColor)
                    .cornerRadius(12)
                    .accentColor(Color.Flash.purpleColor)
            }

            Button {
                saveImage()
            } label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.purpleColor)
                    .cornerRadius(12)
                    .accentColor(Color.Flash.yellowColor)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
        })
        .alert(isPresented: $showSuccessAlert) {
            return Alert(title: Text("Updated🎉"), dismissButton: .default(Text("Ok"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    func saveImage() {
        guard let currentUserID else { return }
        //Update UI on profile!
        self.profileImage = selectedImage
        
        //Update image on database
        ImageManager.shared.uploadProfileImage(userID: currentUserID, image: selectedImage)
        self.showSuccessAlert.toggle()
    }
}

struct SettingsEditImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditImageView(title: "Demo Title", description: "Desc!", selectedImage: UIImage(named: "image1")!, sourceType: .photoLibrary, profileImage: .constant(UIImage(named: "image1")!))
        }
    }
}
