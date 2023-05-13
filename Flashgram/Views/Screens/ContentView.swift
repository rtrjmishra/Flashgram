//
//  ContentView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 01/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    @AppStorage(UserDefaultsFields.displayName) var currentUserDisplayName: String?
    let feedPosts = PostArrayObject(shuffled: false)
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: feedPosts, title: "Feed View")
            }.tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView {
                BrowseView(feedPosts: PostArrayObject(shuffled: true))
            }.tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            NavigationView {
                UploadView()
            }.tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack {
                if let currentUserID, let currentUserDisplayName {
                    NavigationView {
                        ProfileView(displayName: currentUserDisplayName, profileUserId: currentUserID, isMyProfile: true, posts: PostArrayObject(userID: currentUserID))
                    }
                } else {
                    SignUpView()
                }
            }.tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
        }
        .accentColor(Color.Flash.purpleColor)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    } 
}
