//
//  Fonts.swift
//  TwitterClone
//
//  Created by Lawrence on 7/23/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation
import UIKit

enum AppFonts {
    static let regular = UIFont(name: "AvenirNext-Regular", size: 13)
    static let bold = UIFont(name: "AvenirNext-Bold", size: 13)
}

// You might have a problem in the future about font sizes being hard-coded. Try something like:
// final class Font {
//
//     class func withWeight(_ weight: FontWeight, size: Int) -> UIFont? {
//         switch weight {
//             // return the font here...
//         }
//     }
// 
// }
