//
//  AuthService.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 29/04/23.
//

//Used to authneticate users in firebase
//Used to handle user accounts in firebase
import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore

class Constants {
    static let shared = Constants()
    let db_base = Firestore.firestore()
}


class AuthService {
    static let shared = AuthService()
    private var ref_users = Constants.shared.db_base.collection("users")
    
    //MARK: -AUTH USER FUNCS
    func logInUserToFirebase(cred: AuthCredential, completion: @escaping (_ providerID: String?, _ isError: Bool, _ isNewUser: Bool?, _ userID: String?) -> ()) {
        Auth.auth().signIn(with: cred) { (result, error) in
            //Error Check!
            if error != nil {
                print("Error logging into firebase!")
                completion(nil, true, nil, nil)
                return
            }
            
            //Provider Id Check!
            guard let providerId = result?.user.uid else {
                print("Error getting provider Id")
                completion(nil, true, nil, nil)
                return
            }
            
            self.checkIfUserExists(providerId: providerId) { existingUserID in
                if let existingUserID {
                    print("User exist!")
                    completion(providerId, false, false, existingUserID)
                } else {
                    print("User does not exist!")
                    completion(providerId, false, true, nil)
                }
            }
        }
    }
    
    private func checkIfUserExists(providerId: String, completion: @escaping (_ existingUserID: String?) -> ()) {
        //If user id return => User exist in db
        ref_users.whereField(DatabaseUserField.providerID, isEqualTo: providerId).getDocuments { documentSnapshot, error in
            if  let documentSnapshot, documentSnapshot.count > 0, let document = documentSnapshot.documents.first {
                print("Success in getting existing user")
                completion(document.documentID)
                return
            } else {
                print("User does not exist!")
                completion(nil)
            }
        }
    }
    
    func logInUserToApp(userId: String, completion: @escaping (_ success: Bool) -> ()) {
        //Get the user info.
        getUserInfo(userId: userId) { name, bio in
            guard let name, let bio else {
                print("Error getting user info!")
                completion(false)
                return
            }
            
            //Set the info in app(UserDefaults).
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                UserDefaults.standard.set(userId, forKey: UserDefaultsFields.userId)
                UserDefaults.standard.set(bio, forKey: UserDefaultsFields.bio)
                UserDefaults.standard.set(name, forKey: UserDefaultsFields.displayName)
            })
            
            completion(true)
        }
    }
    
    func createNewUserInDatabase(name: String, email: String, provider: String, providerID: String, profileImage: UIImage, completion: @escaping (_ userID: String?) -> ()) {
        //Setup user document.
        let document = ref_users.document()
        let userId = document.documentID
        
        //Uploading images to storage.
        ImageManager.shared.uploadProfileImage(userID: userId, image: profileImage)
        
        //Setting up data in document
        let userData: [String : Any] = [
            DatabaseUserField.displayName: name,
            DatabaseUserField.email: email,
            DatabaseUserField.providerID: providerID,
            DatabaseUserField.provider: provider,
            DatabaseUserField.userId: userId,
            DatabaseUserField.bio: "",
            DatabaseUserField.dateCreated: FieldValue.serverTimestamp()
        ]
        document.setData(userData) { error in
            if let error {
                print("Error uploading data to user document \(error)")
                completion(nil)
            } else {
                completion(userId)
            }
        }
    }
    
    //MARK: -GET USER FUNCS
    func getUserInfo(userId: String, completion: @escaping (_ name: String?, _ bio: String?) -> ()) {
        ref_users.document(userId).getDocument { documentSnapshot, error in
            if  let documentSnapshot,
                let name = documentSnapshot.get(DatabaseUserField.displayName) as? String,
                let bio = documentSnapshot.get(DatabaseUserField.bio) as? String {
                print("Success in getting name")
                completion(name, bio)
                return
            } else if let error {
                print("Error uploading data to user document \(error)")
                completion(nil, nil)
            }
        }
    }
    
    func logOutUser(completion: @escaping (_ success: Bool?) -> ()) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error in signing Out \(error)")
            completion(false)
            return
        }
        
        completion(true)
        
        //Remove UserDefaults.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let defaultsDict = UserDefaults.standard.dictionaryRepresentation()
            defaultsDict.forEach { UserDefaults.standard.removeObject(forKey: $0.key) }
        })
    }
    
    //MARK: -UPDATE USER FUNCS
    func updateUserDisplayName(userID: String, displayName: String, completion: @escaping(_ success: Bool)-> ()) {
        let data: [String: Any] = [
            DatabaseUserField.displayName: displayName
        ]
        ref_users.document(userID).updateData(data, completion: { error in
            guard error == nil else {
                print("Error in updating display name")
                completion(false)
                return
            }
            completion(true)
            return
        })
    }
    
    func updateUserBio(userID: String, bio: String, completion: @escaping(_ success: Bool)-> ()) {
        let data: [String: Any] = [
            DatabaseUserField.bio: bio
        ]
        ref_users.document(userID).updateData(data, completion: { error in
            guard error == nil else {
                print("Error in updating Bio")
                completion(false)
                return
            }
            completion(true)
            return
        })
    }
}
