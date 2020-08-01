//
//  UserManager.swift
//  TwitterClone
//
//  Created by Lawrence on 8/1/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUserManager {
    
    private let auth = Auth.auth()
    private let firebaseDB = Database.database()
    
    /*
     TODO:
     - check if username exists
     
     */
    func createUser(user: UserRegistrationModel, completion: @escaping (_ error: Error?) -> Void) {
        self.auth.createUser(withEmail: user.email, password: user.password) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            
            if let error = error {
                completion(error)
                return
            }
            
            // Create new user to Firebase DB
            guard let uid = result?.user.uid else { fatalError("uid not available") }
            weakSelf.updateUser(newValues: user.childValues, uid: uid) { (error) in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
        }
    }
    
    func updateUser(newValues: [String: Any], uid: String, completion: @escaping (_ error: Error?) -> Void) {
        let path = FirebaseDBPath.user
        
        firebaseDB.reference().child(path).child(uid).updateChildValues(newValues) { (error, _) in
            if let error = error {
                completion(error)
            }
            
            completion(nil)
        }
    }
}
