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
    
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ProfileHeaderView(profileDisplayName: $displayName)
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(displayName: "Ohh Test!", profileUserId: "test123", isMyProfile: true)
        }
    }
}
