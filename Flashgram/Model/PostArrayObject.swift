//
//  PostArrayObject.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        dataArray.append(post)
    }
    
    /// Used for getting post for custom profile
    init(userID: String) {
        print("User ID Posts")
        DataService.shared.downloadPostForUser(userID: userID) { returnedPosts in
            let sortedPosts = returnedPosts.sorted { $0.date > $1.date }
            self.dataArray.append(contentsOf: sortedPosts)
        }
    }
    
    /// Used For Feeds
    init(shuffled: Bool) {
        print("Shuffled Posts")
        DataService.shared.downloadPostForFeed { returnedPosts in
            if shuffled {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
    
    
}
