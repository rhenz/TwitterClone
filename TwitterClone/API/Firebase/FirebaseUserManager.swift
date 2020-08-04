//
//  UserManager.swift
//  TwitterClone
//
//  Created by Lawrence on 8/1/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class FirebaseUserManager {
    
    private let auth = Auth.auth()
    private let firebaseDB = Database.database()
    private let storage = Storage.storage()
    private let profileImageStorageUrl = "gs://twitterclone-309b1.appspot.com"
    
    /*
     TODO:
     - check if username exists
     
     */
    func createUser(user: UserRegistrationModel, completion: @escaping (_ error: Error?) -> Void) {
        self.auth.createUser(withEmail: user.email, password: user.password) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            
            func updateUser(_ imageUrlString: String? = nil) {
                // Create new user to Firebase DB
                guard let uid = result?.user.uid else { fatalError("uid not available") }
                var userDict = user.childValues
                if let url = imageUrlString { userDict["profileImage"] = url }
                weakSelf.updateUser(newValues: userDict, uid: uid) { (error) in
                    if let error = error {
                        completion(error)
                        return
                    }
                    completion(nil)
                }
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            // Check if there's image data
            if let imageData = user.imageData {
                weakSelf.addProfileImage(imageData: imageData) { (urlString, error) in
                    if let error = error {
                        completion(error)
                        return
                    }
                    updateUser(urlString)
                }
            } else {
                updateUser()
            }
        }
    }
    
    func updateUser(newValues: [String: Any], uid: String, completion: @escaping (_ error: Error?) -> Void) {
        firebaseDB.reference().child(FirebaseDBPath.user).child(uid).updateChildValues(newValues) { (error, _) in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }
    
    func addProfileImage(imageData: Data, completion: @escaping (_ imageUrlString: String?, _ error: Error?) -> Void) {
        let filename = UUID().uuidString
        let ref = storage.reference(forURL: profileImageStorageUrl)
            .child(FirebaseStoragePath.profilePicture)
            .child(filename)
        
        // Image type is jpeg always
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload image data
        ref.putData(imageData, metadata: metadata) { (_, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Get URL
            ref.downloadURL { (url, error) in
                guard let imageUrlString = url?.absoluteString else {
                    completion(nil, error)
                    return
                }
                completion(imageUrlString, nil)
            }
        }
    }
}
