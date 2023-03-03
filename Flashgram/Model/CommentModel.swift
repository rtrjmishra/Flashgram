//
//  CommentModel.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import Foundation
import SwiftUI

struct CommentModel: Identifiable, Hashable {
    var id = UUID()
    
    var commentId: String
    var userId: String
    var username: String
    var content: String
    var date: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

