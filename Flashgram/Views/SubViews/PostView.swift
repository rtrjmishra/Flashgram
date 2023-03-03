//
//  PostView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 03/03/23.
//

import SwiftUI

struct PostView: View {
    @State var postModel: PostModel
    var showHeaderAndFooter: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if showHeaderAndFooter {
                //MARK: Header
                HStack {
                    Image("image1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(15)
                    Text(postModel.username)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }
                .padding(6)
            }
            
            //MARK: Image
            Image("image1")
                .resizable()
                .scaledToFill()
                .frame(width: showHeaderAndFooter ? 300 : 80,
                       height: showHeaderAndFooter ? 300 : 80)
            
            if showHeaderAndFooter {
                //MARK: Footer
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "heart")
                        .font(.title3)
                    
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                    Spacer()
                }
                .padding(6)
                
                if let caption = postModel.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(6)
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostView(postModel: PostModel(postId: "", userId: "", username: "abc", caption: "This is a test caption!", date: Date(), noOfLikes: 2, likedByUser: true), showHeaderAndFooter: true)
        }
    }
}
