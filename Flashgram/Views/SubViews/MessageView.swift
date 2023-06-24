//
//  MessageView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI

struct MessageView: View {
    @State var commentModel: CommentModel
    @State var profilePicture = UIImage(named: "loadingImage")!
    
    var body: some View {
        HStack {
            NavigationLink {
                LazyView {
                    ProfileView(displayName: commentModel.username, profileUserId: commentModel.userId, isMyProfile: false, posts: PostArrayObject(userID: commentModel.userId))
                }
            } label: {
                Image(uiImage: profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(commentModel.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(commentModel.content)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            
            Spacer(minLength: 0)
        }
        .onAppear {
            getProfileImage()
        }
    }
    
    func getProfileImage() {
        ImageManager.shared.downloadProfileImage(userID: commentModel.userId) { image in
            if let image {
                self.profilePicture = image
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(commentModel: CommentModel(commentId: "", userId: "", username: "abc", content: "Hey this is a fake comment!", date: Date()))
            .previewLayout(.sizeThatFits)
    }
}
