//
//  TintedImage.swift
//  TwitterClone
//
//  Created by Lawrence on 7/26/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

extension UIImage {
    func setImageTintable() {
        self.withRenderingMode(.alwaysTemplate)
    }
}
