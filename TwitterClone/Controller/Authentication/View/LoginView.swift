//
//  LoginView.swift
//  TwitterClone
//
//  Created by Lawrence on 7/23/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    // MARK: - Constants
    private enum Text: String, CaseIterable {
        case email = "Email"
        case password = "Password"
        case loginButton = "Log In"
        case signUpLabel = "Don't have an account?"
        case signUpButton = "Sign Up"
    }
    
    // MARK: - Properties
    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    lazy var emailTextFieldView: InputTextView = {
        let tf = InputTextView(iconImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), placeholderText: Text.email.rawValue, keyboardType: .emailAddress)
        return tf
    }()
    
    lazy var passwordTextFieldView: InputTextView = {
        let tf = InputTextView(iconImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), placeholderText: Text.password.rawValue, keyboardType: .default)
        tf.textField.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.loginButton.rawValue, for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = AppFonts.bold
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var inputStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.emailTextFieldView, self.passwordTextFieldView])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.inputStackView, self.loginButton])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular
        label.textColor = .white
        label.text = Text.signUpLabel.rawValue
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.signUpButton.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFonts.bold
        return button
    }()
    
    lazy var signUpStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.signUpLabel, self.signUpButton])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 3
        return sv
    }()
    
    // MARK: - Handlers
    // A more idiomatic implementation of button handlers would be to use the delegation pattern.
    // Delegates (or even closure button handlers) can be overkill for simple buttons, but
    // delegates are extremely helpful for complex views that you might ship in an SDK, for example.
    var didLoginButtonPressed: ((_ sender: UIButton) -> Void)?
    var didSignUpButtonPressed: ((_ sender: UIButton) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    func commonInit() {
        self.backgroundColor = .twitterBlue
        
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.signUpStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.logoImageView)
        self.addSubview(self.mainStackView)
        self.addSubview(self.signUpStackView)
                
        // Setup constraints
        NSLayoutConstraint.activate([
            self.logoImageView.heightAnchor.constraint(equalToConstant: 80),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 80),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            self.emailTextFieldView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            self.passwordTextFieldView.heightAnchor.constraint(equalTo: self.emailTextFieldView.heightAnchor),
            self.loginButton.heightAnchor.constraint(equalTo: self.emailTextFieldView.heightAnchor),
            
            self.mainStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 20),
            self.mainStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.mainStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            self.signUpStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.signUpStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // Setup Button Handlers
        self.loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func loginButtonPressed(_ sender: UIButton) {
        self.didLoginButtonPressed?(sender)
    }
    
    @objc private func signUpButtonPressed(_ sender: UIButton) {
        self.didSignUpButtonPressed?(sender)
    }
    
    func getEmail() -> String? {
        return self.emailTextFieldView.textField.text
    }
    
    func getPassword() -> String? {
        return self.passwordTextFieldView.textField.text
    }
}
