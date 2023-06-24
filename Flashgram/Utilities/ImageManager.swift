//
//  ImageManager.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 29/04/23.
//

import Foundation
import FirebaseStorage //Holds photos and videos.
import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    static let shared = ImageManager()
    private var ref_store = Storage.storage()
    
    //MARK: -Public Funcs
    func uploadProfileImage(userID: String, image: UIImage) {
        //Path to save image.
        let path = getProfileImagePath(userID: userID)
        
        //Save Image.
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { _ in }
        }
    }
    
    func uploadPostImage(postID: String, image: UIImage, completion: @escaping(_ success: Bool) -> ()) {
        //Path to save image.
        let path = getPostImagePath(postID: postID)
        
        //Save image
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image, completion: { success in
                DispatchQueue.main.async {
                    completion(success)
                }
            })
        }
    }
    
    func downloadProfileImage(userID: String, completion: @escaping(_ image: UIImage?) -> ()) {
        //Get path where image is saved
        let path = getProfileImagePath(userID: userID)
        
        //Download Image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) {image in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func downloadPostImage(postID: String, completion: @escaping(_ image: UIImage?) -> ()) {
        let path = getPostImagePath(postID: postID)
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path, completion: { image in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
    
    //MARK: -Private(Helper) Funcs
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        return ref_store.reference(withPath: userPath)
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "post/\(postID)/1"//image name has to be different
        return ref_store.reference(withPath: postPath)
    }
    
    private func uploadImage(path: StorageReference, image: UIImage, completion: @escaping (_ success: Bool) -> ()) {
        //Photo Compression
        var compression: CGFloat = 1.0
        let maxFileSize: Int = 240 * 240 //Max file size of photo we want to save.
        let maxCompression: CGFloat = 0.5
        
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting image data")
            completion(false)
            return
        }
        
        while(originalData.count > maxFileSize && compression > maxCompression) {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
        }
        
        //Photo Data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting image data")
            completion(false)
            return
        }
        
        //Photo Metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        //Saving the data
        path.putData(finalData, metadata: metadata) { data, error in
            if let error {
                print("Error on uploading image! \(error)")
                completion(false)
                return
            } else {
                print("Success on uploading image!")
                completion(true)
                return
            }
        }
    }
    
    private func downloadImage(path: StorageReference, completion: @escaping (_ image: UIImage?) -> ()) {
        if let cachedImage = imageCache.object(forKey: path) {
            print("Image found in cache")
            completion(cachedImage)
            return
        } else {
            path.getData(maxSize: 27*1024*1024) { imageData, error in
                if let imageData, let image = UIImage(data: imageData) {
                    imageCache.setObject(image, forKey: path)
                    completion(image)
                    return
                } else {
                    print("Error in getting data of image from web")
                    completion(nil)
                    return
                }
            }
        }
    }
    
}
