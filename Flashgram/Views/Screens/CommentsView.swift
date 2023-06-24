//
//  CommentsView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI

struct CommentsView: View {
    @State var submissionText: String = ""
    @State var commentsArray = [CommentModel]()
    var post: PostModel
    
    @State var profilePicture: UIImage = UIImage(named: "loadingImage")!
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    @AppStorage(UserDefaultsFields.displayName) var currentDisplayName: String?
    
    var body: some View {
        VStack {
            //Messages Scroll View!
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(commentsArray, id: \.self) { comment in
                        MessageView(commentModel: comment)
                    }
                }
            }
            
            //Bottom messagecreate view.
            Divider()
                .background(Color.Flash.purpleColor)
            
            HStack {
                Image(uiImage: profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText)
                
                Button {
                    if appropriateText() {
                        addComment()
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }
                .accentColor(Color.Flash.purpleColor)
            }
            .padding(6)
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getComments()
            getProfilePicture()
        }
    }
    
    //MARK: Helper Functions
    func getProfilePicture() {
        guard let currentUserID else {
            print("User ID missing!")
            return
        }
        ImageManager.shared.downloadProfileImage(userID: currentUserID) { image in
            guard let image else {
                print("Image not found!")
                return
            }
            self.profilePicture = image
        }
    }
    
    func getComments() {
        self.commentsArray.removeAll()
        DataService.shared.downloadCommentsForPost(postID: post.postId) { comments in
            self.commentsArray.append(contentsOf: comments)
        }
    }
    
    func appropriateText() -> Bool {
        if submissionText.count < 3 {
            return false
        }
        
        return true
    }
    
    func addComment() {
        guard let currentUserID, let currentDisplayName else {
            print("Error as user id or name missing!")
            return
        }
        DataService.shared.uploadComment(postID: post.postId, comment: submissionText, displayName: currentDisplayName, userID: currentUserID) { success, commentID in
            if success, let commentID {
                let newComment = CommentModel(commentId: commentID, userId: currentUserID, username: currentDisplayName, content: submissionText, date: Date())
                self.commentsArray.append(newComment)
                self.submissionText = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView(submissionText: "", post: PostModel(postId: "", userId: "", username: "", date: Date(), noOfLikes: 0, likedByUser: false))
        }
    }
}
