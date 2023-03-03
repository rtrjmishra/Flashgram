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
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(commentsArray, id: \.self) { comment in
                        MessageView(commentModel: comment)
                    }
                }
            }
            
            Divider()
                .background(Color.Flash.purpleColor)
            
            HStack {
                Image("image1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText)
                
                Button {
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
        }
    }
    
    //MARK: Helper Functions
    func getComments() {
        //get comments from database but rn only static!
        let comment1 = CommentModel(commentId: "", userId: "", username: "user1", content: "Wow from user1", date: Date())
        let comment2 = CommentModel(commentId: "", userId: "", username: "user2", content: "Wow from user2", date: Date())
        let comment3 = CommentModel(commentId: "", userId: "", username: "user3", content: "Wow from user3", date: Date())
        let comment4 = CommentModel(commentId: "", userId: "", username: "user4", content: "Wow from user4", date: Date())
        
        self.commentsArray.append(comment1)
        self.commentsArray.append(comment2)
        self.commentsArray.append(comment3)
        self.commentsArray.append(comment4)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView(submissionText: "")
        }
    }
}
