//
//  SettingsView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 15/04/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                //MARK: - Section Flashgram
                GroupBox(label: SettingsLabelView(labelText: "Flashgram", labelImage: "dot.radiowaves.left.and.right")) {
                    HStack(alignment: .center, spacing: 10) {
                        Image("uploadPageLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        Text("Flashgram is an entertaining programmed application that is similar to Instagram in many ways, with the exception of chatting, which will be included in later editions!")
                            .font(.footnote)
                    }
                }
                .padding()
                
                //MARK: - Section Profile
                GroupBox(label: SettingsLabelView(labelText: "Flashgram", labelImage: "dot.radiowaves.left.and.right")) {
                    NavigationLink {
                        SettingsEditTextView(title: "Display Name", description: "You can edit your display name here, this will be seen by other users on your profile.", submissionText: "Current Display Name", placeholder: "Your display name here...")
                    } label: {
                        SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.Flash.purpleColor)
                    }
                    
                    NavigationLink {
                        SettingsEditTextView(title: "Bio", description: "You can edit your bio here, this will be seen by other users when people see your profile profile.", submissionText: "Current Bio", placeholder: "Your Bio...")
                    } label: {
                        SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.Flash.purpleColor)
                    }
                    
                    NavigationLink {
                        SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile and on your posts, most users make an image of themselves.", selectedImage: UIImage(named: "image1")!, sourceType: .photoLibrary)
                    } label: {
                        SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.Flash.purpleColor)
                    }

                    SettingsRowView(leftIcon: "figure.walk", text: "Sign Out", color: Color.Flash.purpleColor)
                }
                .padding()
                
                //MARK: - Section Application
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")) {
                    Button { openCustomURL(urlString: "https://www.google.com") } label: { SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.Flash.yellowColor) }

                    Button {
                        openCustomURL(urlString: "https://www.bing.com") } label: { SettingsRowView(leftIcon: "folder.fill", text: "Terms And Conditions", color: Color.Flash.yellowColor) }
                    
                    Button { openCustomURL(urlString: "https://www.yahoo.com") } label: { SettingsRowView(leftIcon: "globe", text: "Flashgram's Website", color: Color.Flash.yellowColor) }
                }
                .padding()
                
                //MARK: -Section Sign Off
                GroupBox {
                    Text("Flashgram was made for fun and learn. \n All Rights Reserved. \n Rituraj Mishra. \n Copyright 2023 💙")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 40)
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: Button { presentationMode.wrappedValue.dismiss() } label: { Image(systemName: "xmark").font(.headline) } .accentColor(.primary))
        }
    }
    
    //MARK: - Functions
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
