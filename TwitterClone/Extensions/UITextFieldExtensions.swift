//
//  UITextFieldExtension.swift
//  TwitterClone
//
//  Created by Lawrence on 7/31/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
