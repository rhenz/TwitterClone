//
//  InputTextView.swift
//  TwitterClone
//
//  Created by Lawrence on 7/23/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation
import UIKit

class InputTextView: UIView {
    // MARK: - Properties
    var iconImage: UIImage
    var placeholderText: String
    var keyboardType: UIKeyboardType
    
    var textFieldTextColor: UIColor = .white
    
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = self.iconImage
        return iv
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = self.placeholderText
        tf.font = AppFonts.regular
        tf.attributedPlaceholder = NSAttributedString(string: self.placeholderText,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.keyboardType = self.keyboardType
        tf.textColor = self.textFieldTextColor
        return tf
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.iconImageView, self.textField])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 10
        return sv
    }()
    
    // MARK: - Init
    init(iconImage: UIImage, placeholderText: String, keyboardType: UIKeyboardType) {
        self.iconImage = iconImage
        self.placeholderText = placeholderText
        self.keyboardType = keyboardType
        super.init(frame: .zero)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.addBottomBorder()
    }
    
    // MARK: - Helper Methods
    private func commonInit() {
        
        self.horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(horizontalStackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            self.iconImageView.heightAnchor.constraint(equalTo: self.horizontalStackView.heightAnchor),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            self.horizontalStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.horizontalStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.horizontalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.horizontalStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func addBottomBorder() {
        
        // Choice of layer is good for efficiency, although be careful because they don't respond to Autolayout changes.
        let thickness: CGFloat = 2
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: thickness)
        bottomBorder.backgroundColor = UIColor.white.cgColor
        bottomBorder.opacity = 0.5
        self.layer.addSublayer(bottomBorder)
    }
}
