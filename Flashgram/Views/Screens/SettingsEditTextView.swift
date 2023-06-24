//
//  SettingsEditTextView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 27/04/23.
//

import SwiftUI

struct SettingsEditTextView: View {
    @State var title: String = ""
    @State var description: String = ""
    @State var submissionText: String = ""
    @State var placeholder: String = ""
    @State var settingsEditTextOption: SettingsEditTextOptions
    @Binding var profileText: String
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    @State var showSuccessAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.Flash.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button {
                if appropriateText() {
                    saveText()
                }
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
        .alert(isPresented: $showSuccessAlert) {
            return Alert(title: Text("Updated🎉"), dismissButton: .default(Text("Ok"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    func appropriateText() -> Bool {
        if submissionText.count < 3 {
            return false
        }
        return true
    }
    
    func saveText() {
        guard let currentUserID else { return }
        switch settingsEditTextOption {
        case .displayName:
            //Update UI on profile!
            self.profileText = submissionText
            //Update Userdefaults!
            UserDefaults.standard.set(submissionText, forKey: UserDefaultsFields.displayName)
            
            //Update Firebase!
            //1.)Posts!
            DataService.shared.updateDisplayNameOnPosts(userID: currentUserID, displayName: submissionText)
            
            //2.)Profile!
            AuthService.shared.updateUserDisplayName(userID: currentUserID, displayName: submissionText) { success in
                if success {
                    showSuccessAlert.toggle()
                }
            }
        case .bio:
            //Update UI on profile!
            self.profileText = submissionText
            //Update Userdefaults!
            UserDefaults.standard.set(submissionText, forKey: UserDefaultsFields.bio)
            
            //Update Firebase!
            AuthService.shared.updateUserBio(userID: currentUserID, bio: submissionText) { success in
                if success {
                    showSuccessAlert.toggle()
                }
            }
        }
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditTextView(settingsEditTextOption: .displayName, profileText: .constant("Test!"))
        }
    }
}
