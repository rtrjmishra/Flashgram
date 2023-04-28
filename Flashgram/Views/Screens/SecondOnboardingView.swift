//
//  SecondOnboardingView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 28/04/23.
//

import SwiftUI

struct SecondOnboardingView: View {
    @State var displayName: String = ""
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var imageSelected: UIImage = UIImage(named: "image1")!
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("uploadPageLogo")
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
    }
    
    //MARK: - Function
    
    func createProfile() {
        
    }
}

struct SecondOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SecondOnboardingView()
    }
}
