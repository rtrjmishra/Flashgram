//
//  ImageGridView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI

struct ImageGridView: View {
    @ObservedObject var posts: PostArrayObject
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                  alignment: .center,
                  spacing: 10) {
            ForEach(posts.dataArray, id: \.self) { post in
                NavigationLink {
                    FeedView(posts: PostArrayObject(post: post), title: "Post")
                } label: {
                    PostView(postModel: post, showHeaderAndFooter: false, addHeartAnimationToView: false)
                }
            }
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(posts: PostArrayObject())
            .previewLayout(.sizeThatFits)
    }
}
