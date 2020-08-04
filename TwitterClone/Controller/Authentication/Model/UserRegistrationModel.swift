//
//  UserRegistrationModel.swift
//  TwitterClone
//
//  Created by Lawrence on 7/30/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation

struct UserRegistrationModel: Encodable {
    let email: String
    let password: String
    let fullName: String
    let username: String
    let imageData: Data?
    
    var childValues: [String: Any] {
        return [
            "fullName": self.fullName,
            "username": self.username,
            "email": self.email
        ]
    }
}
