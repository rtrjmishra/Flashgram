//
//  SecondOnboardingView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 28/04/23.
//

import SwiftUI

struct SecondOnboardingView: View {
    @Binding var displayName: String
    @Binding var email: String
    @Binding var providerId: String
    @Binding var provider: String
    
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var imageSelected: UIImage = UIImage(named: "image1")!
    
    @State var showError: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("onboardingLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
                .shadow(radius: 20)
                .padding(.vertical)
            
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.Flash.yellowColor)
            
            TextField("Enter your name...", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.Flash.purpleColor)
                .background(Color.Flash.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding()
            
            Button {
                self.showImagePicker.toggle()
            } label: {
                Text("Finish: Add Profile Picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.yellowColor)
                    .cornerRadius(12)
                    .accentColor(Color.Flash.purpleColor)
                    .shadow(radius: 20)
            }
            .padding()
            .opacity(displayName.isEmpty ? 0 : 1)
            .animation(.easeOut(duration: 1))

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Flash.purpleColor.ignoresSafeArea())
        .sheet(isPresented: $showImagePicker, onDismiss: createProfile, content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        })
        .alert(isPresented: $showError) {
            return Alert(title: Text("Error Creating Profile 😰"))
        }
    }
    
    //MARK: - Function
    func createProfile() {
        AuthService.shared.createNewUserInDatabase(name: displayName, email: email, provider: provider, providerID: providerId, profileImage: imageSelected) { userID in
            guard let userID else {
                print("Error creating user to database!")
                self.showError.toggle()
                return
            }
            
            AuthService.shared.logInUserToApp(userId: userID) { success in
                if success {
                    print("User logged In")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                } else {
                    print("Error logging in")
                    self.showError.toggle()
                }
            }
            
        }
    }
}

struct SecondOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SecondOnboardingView(displayName: .constant(""), email: .constant(""), providerId: .constant(""), provider: .constant(""))
    }
}
