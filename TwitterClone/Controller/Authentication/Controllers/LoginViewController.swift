//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Lawrence on 7/23/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    private var loginView = LoginView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.view = self.loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupButtonHandlers()
    }
    
    // MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - Helper Methods
    func setupView() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupButtonHandlers() {
        self.loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        self.loginView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func loginButtonPressed(_ sender: UIButton) {
        print("Login button pressed")
    }
    
    @objc func signUpButtonPressed(_ sender: UIButton) {
        print("Signup button pressed")
        let vc = RegistrationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
