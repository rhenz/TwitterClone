//
//  UserRegistrationModelTests.swift
//  TwitterCloneTests
//
//  Created by Lawrence on 7/30/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import XCTest
@testable import TwitterClone


class UserRegistrationModelTests: XCTestCase {
    
    var sut: UserRegistrationModel!
    let email = "john@gmail.com"
    let password = "Abcdefg!"
    let fullName = "John Salvador"
    let username = "johnsalvador"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testUserRegistrationModel_CreateInstance() {
        sut = UserRegistrationModel(email: "john@gmail.com", password: "12345678", fullName: "John Salvador", username: "johnsalvador")
        XCTAssertNotNil(sut)
    }
    
    
}
