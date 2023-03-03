//
//  PostArrayObject.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    
    init() {
        let post1 = PostModel(postId: "", userId: "", username: "user1", date: Date(), noOfLikes: 2, likedByUser: true)
        let post2 = PostModel(postId: "", userId: "", username: "user2", caption: "Caption by user2", date: Date(), noOfLikes: 2, likedByUser: true)
        let post3 = PostModel(postId: "", userId: "", username: "user3", caption: "Caption by user3", date: Date(), noOfLikes: 2, likedByUser: true)
        let post4 = PostModel(postId: "", userId: "", username: "user4", caption: "Caption by user4 which is a realyy long caption ng;l!!!!", date: Date(), noOfLikes: 2, likedByUser: true)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        dataArray.append(post)
    }
}
