//
//  Validator.swift
//  TwitterClone
//
//  Created by Lawrence on 7/31/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
    case fullName
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .fullName: return FullNameValidator()
        }
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shouldn't contain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$", options: .caseInsensitive).firstMatch(in: value,
                                                                                                       options: [],
                                                                                                       range: NSRange(location: 0,
                                                                                                                      length: value.count)) == nil {
                throw ValidationError("Invalid username, should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, should not contain whitespaces, numbers or special characters")
        }
        return value
    }
}

struct FullNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 2 else {
            throw ValidationError("Full Name must contain more than two characters")
        }
        
        guard value.count < 22 else {
            throw ValidationError("Full Name shouldn't contain more than 21 characters")
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z ]{1,22}$", options: .caseInsensitive).firstMatch(in: value,
                                                                                                       options: [],
                                                                                                       range: NSRange(location: 0,
                                                                                                                      length: value.count)) == nil {
                throw ValidationError("Invalid Full Name, should not contain numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid Full Name, should not contain numbers or special characters")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",
                                       options: .caseInsensitive).firstMatch(in: value,
                                                                             options: [],
                                                                             range: NSRange(location: 0,
                                                                                            length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
                                       options: .caseInsensitive).firstMatch(in: value,
                                                                             options: [],
                                                                             range: NSRange(location: 0,
                                                                                            length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}
