//
//  RegistrationViewController.swift
//  TwitterClone
//
//  Created by Lawrence on 7/23/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    private var registrationView = RegistrationView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.view = self.registrationView
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
        self.view.backgroundColor = .twitterBlue
    }
    
    func setupButtonHandlers() {
        self.registrationView.didLoginButtonPressed = { sender in
            print("Login Button Pressed")
            
            // pop
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Selectors

}
