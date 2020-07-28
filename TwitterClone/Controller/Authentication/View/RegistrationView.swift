//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Lawrence on 7/25/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
    // MARK: - Constants
    private enum Text: String {
        case signUpButton = "Sign Up"
        case email = "Email"
        case password = "Password"
        case fullName = "Full Name"
        case username = "Username"
        case loginLabel = "Already have an account?"
        case loginButton = "Log in"
    }
    
    // MARK: - Properties
    private var didSetProfileImageView: Bool = false
    
    // Views
    lazy var addProfilePicButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus_photo")
        image.setImageTintable()
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular
        label.textColor = .white
        label.text = Text.loginLabel.rawValue
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.loginButton.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFonts.bold
        return button
    }()
    
    lazy var loginStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.loginLabel, self.loginButton])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 3
        return sv
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
    
    lazy var fullNameTextView: InputTextView = {
        let tf = InputTextView(iconImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), placeholderText: Text.fullName.rawValue, keyboardType: .default)
        return tf
    }()
    
    lazy var usernameTextView: InputTextView = {
        let tf = InputTextView(iconImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), placeholderText: Text.username.rawValue, keyboardType: .default)
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.signUpButton.rawValue, for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = AppFonts.bold
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var inputStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.emailTextFieldView, self.passwordTextFieldView, self.fullNameTextView, self.usernameTextView])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.inputStackView, self.signUpButton])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    // MARK: - Handlers
    var didLoginButtonPressed: ((_ sender: UIButton) -> Void)?
    var didSignUpButtonPressed: ((_ sender: UIButton) -> Void)?
    var didProfilePicButtonPressed: ((_ sender: UIButton) -> Void)?
    
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
        
        self.addProfilePicButton.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.loginStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.addProfilePicButton)
        self.addSubview(self.mainStackView)
        self.addSubview(self.loginStackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            
            self.addProfilePicButton.heightAnchor.constraint(equalToConstant: 90),
            self.addProfilePicButton.widthAnchor.constraint(equalToConstant: 90),
            self.addProfilePicButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.addProfilePicButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.emailTextFieldView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            self.passwordTextFieldView.heightAnchor.constraint(equalTo: self.emailTextFieldView.heightAnchor),
            self.fullNameTextView.heightAnchor.constraint(equalTo: self.emailTextFieldView.heightAnchor),
            self.usernameTextView.heightAnchor.constraint(equalTo: self.emailTextFieldView.heightAnchor),
            self.signUpButton.heightAnchor.constraint(equalTo: self.emailTextFieldView.heightAnchor),
            
            self.mainStackView.topAnchor.constraint(equalTo: self.addProfilePicButton.bottomAnchor, constant: 20),
            self.mainStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.mainStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            self.loginStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.loginStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // Setup Button Handlers
        self.loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        self.addProfilePicButton.addTarget(self, action: #selector(addProfilePicButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func loginButtonPressed(_ sender: UIButton) {
        self.didLoginButtonPressed?(sender)
    }
    
    @objc private func addProfilePicButtonPressed(_ sender: UIButton) {
        self.didProfilePicButtonPressed?(sender)
    }
    
    private func setImageView() {
        if !self.didSetProfileImageView {
            self.addProfilePicButton.imageView?.contentMode = .scaleAspectFill
            self.addProfilePicButton.layer.cornerRadius = self.addProfilePicButton.frame.height/2
            self.addProfilePicButton.layer.borderColor = UIColor.white.cgColor
            self.addProfilePicButton.layer.borderWidth = 1
            self.addProfilePicButton.layer.masksToBounds = true
            
            self.didSetProfileImageView = true
        }
    }
    
    public func setProfileImage(_ image: UIImage) {
        self.setImageView()
        self.addProfilePicButton.setImage(image, for: .normal)
    }
    
}
