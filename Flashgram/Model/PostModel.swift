//
//  PostModel.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    var id = UUID()
    
    var postId: String
    var userId: String
    var username: String
    var caption: String?
    var date: Date
    var noOfLikes: Int
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
