//
//  DataService.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 30/04/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase


//This will be used to upload and download data(other than users).
class DataService {
    static let shared = DataService()
    private var ref_posts = Constants.shared.db_base.collection("posts")
    private var ref_reports = Constants.shared.db_base.collection("reports")
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    
    //MARK: - CREATE functions
    func uploadPost(image: UIImage, caption: String?, displayName: String, userID: String, completion: @escaping (_ success: Bool) -> ()) {
        //Create new post document.
        let document = ref_posts.document()
        let postID = document.documentID
        
        //Upload Image to storage
        ImageManager.shared.uploadPostImage(postID: postID, image: image) { success in
            if success {
                //Post Image Successfully uploaded, now just post rest details.
                let postData: [String: Any] = [
                    DatabasePostField.postID: postID,
                    DatabasePostField.userId: userID,
                    DatabasePostField.displayName: displayName,
                    DatabasePostField.caption: caption,
                    DatabasePostField.dateCreated: FieldValue.serverTimestamp()
                ]
                
                document.setData(postData) { error in
                    if let error {
                        print("Error uploading data to post document \(error)")
                        completion(false)
                        return
                    }
                    
                    print("Success uploading data to post document")
                    completion(true)
                    return
                }
            } else {
                print("Post not uploaded successfully")
                completion(false)
                return
            }
        }
    }
    
    func uploadReport(reason: String, postID: String, completion: @escaping(_ success: Bool) -> ()) {
        let data: [String: Any] = [
            DatabaseReportField.content: reason,
            DatabaseReportField.postID: postID,
            DatabaseReportField.dateCreated: FieldValue.serverTimestamp()
        ]
        
        ref_reports.addDocument(data: data) { error in
            guard let error else {
                return completion(true)
            }
            print("Error in reporting \(error)")
            return completion(false)
        }
    }
    
    //MARK: - GET Functions
    func downloadPostForUser(userID: String, completion: @escaping(_ post: [PostModel]) -> ()) {
        ref_posts.whereField(DatabasePostField.userId, isEqualTo: userID).getDocuments { querySnap, error in
            guard error == nil else {
                print("Error in getting post from firebase")
                return completion([])
            }
            
            completion(self.getPostSnapshot(querySnap: querySnap))
        }
    }
    
    func downloadPostForFeed(completion: @escaping(_ post: [PostModel]) -> ()) {
        ref_posts.order(by: DatabasePostField.dateCreated, descending: true).limit(to: 50).getDocuments { querySnap, error in
            guard error == nil else {
                print("Error in getting post from firebase for feed")
                return completion([])
            }
            
            completion(self.getPostSnapshot(querySnap: querySnap))
        }
    }
    
    /// Does all the deed to be done for querysnapshot!
    private func getPostSnapshot(querySnap: QuerySnapshot?) -> [PostModel] {
        var postArray = [PostModel]()
        if let querySnap, !querySnap.documents.isEmpty {
            for doc in querySnap.documents {
                let postID = doc.documentID
                if let userID = doc.get(DatabasePostField.userId) as? String, let displayName = doc.get(DatabasePostField.displayName) as? String, let timeStamp = doc.get(DatabasePostField.dateCreated) as? Timestamp {
                    let caption = doc.get(DatabasePostField.caption) as? String
                    let likeCount = doc.get(DatabasePostField.likeCount) as? Int ?? 0
                    let date = timeStamp.dateValue()
                    
                    var likedByUser: Bool = false
                    if let userIDArray = doc.get(DatabasePostField.likedBy) as? [String], let currentUserID {
                        likedByUser = userIDArray.contains(currentUserID)
                    }
                    
                    
                    postArray.append(PostModel(postId: postID, userId: userID, username: displayName, caption: caption, date: date, noOfLikes: likeCount, likedByUser: likedByUser))
                }
            }
            return postArray
        } else {
            print("No documents found in snapshot!")
            return postArray
        }
    }
    
    //MARK: -UPDATE Functions
    func likePost(postID: String, currentUserID: String) {
        //Update the post count
        //Update the data of users who liked the post
        let increment: Int64 = 1
        let updatedData: [String: Any] = [
            DatabasePostField.likeCount: FieldValue.increment(increment),
            DatabasePostField.likedBy: FieldValue.arrayUnion([currentUserID])
        ]
        
        ref_posts.document(postID).updateData(updatedData)
    }
    
    func unlikePost(postID: String, currentUserID: String) {
        //Update the post count
        //Update the data of users who liked the post
        let increment: Int64 = -1
        let updatedData: [String: Any] = [
            DatabasePostField.likeCount: FieldValue.increment(increment),
            DatabasePostField.likedBy: FieldValue.arrayRemove([currentUserID])
        ]
        
        ref_posts.document(postID).updateData(updatedData)
    }
}

