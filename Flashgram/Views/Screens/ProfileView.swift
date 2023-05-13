//
//  ProfileView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 09/04/23.
//

import SwiftUI

struct ProfileView: View {
    @State var displayName: String
    var profileUserId: String
    var isMyProfile: Bool
    @State var showSettings: Bool = false
    @State var showAlert: Bool = false
    @State var profileImage: UIImage = UIImage(named: "loadingImage")!
    
    var posts: PostArrayObject
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ProfileHeaderView(profileDisplayName: $displayName, profileImage: $profileImage)
            Divider()
            ImageGridView(posts: posts)
        }
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button { showSettings.toggle() } label: { Image(systemName: "line.horizontal.3").opacity(isMyProfile ? 1 : 0) }
            .accentColor(Color.Flash.purpleColor))
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .onAppear {
            getProfileImage()
        }
        .alert(isPresented: $showAlert) {
            return Alert(title: Text("Cannot get the image from Web😫"))
        }
    }
    
    //MARK: Functions
    private func getProfileImage() {
        ImageManager.shared.downloadProfileImage(userID: profileUserId) { image in
            guard let image else {
                showAlert.toggle()
                return
            }
            self.profileImage = image
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(displayName: "Ohh Test!", profileUserId: "test123", isMyProfile: true, posts: PostArrayObject(shuffled: false))
        }
    }
}
