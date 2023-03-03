//
//  ContentView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 01/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: PostArrayObject(), title: "Feed View")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView{
                BrowseView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            NavigationView{
                UploadView()
            }
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            Text("Screen 4")
                .tabItem {
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
