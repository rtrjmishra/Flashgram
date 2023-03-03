//
//  FeedView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 03/03/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var posts: PostArrayObject
    var title: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(posts.dataArray, id: \.self) { post in
                    PostView(postModel: post, showHeaderAndFooter: true)
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(posts: PostArrayObject(), title: "Feed View Test")
        }
    }
}
