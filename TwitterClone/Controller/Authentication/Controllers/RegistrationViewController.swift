//
//  RegistrationViewController.swift
//  TwitterClone
//
//  Created by Lawrence on 7/23/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    private var registrationView = RegistrationView()
    
    private let imagePicker = UIImagePickerController()
    private var selectedImage: UIImage?
    
    private let userManager = FirebaseUserManager()
    
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
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
    }
    
    func setupButtonHandlers() {
        self.registrationView.addProfilePicButton.addTarget(self, action: #selector(addProfilePicButtonPressed(_:)), for: .touchUpInside)
        self.registrationView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
        self.registrationView.loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
    }
    
    func validateSignUpFields() {
        let v = self.registrationView
        do {
            let email = try v.emailTextFieldView.textField.validatedText(validationType: .email)
            let password = try v.passwordTextFieldView.textField.validatedText(validationType: .password)
            let fullName = try v.fullNameTextView.textField.validatedText(validationType: .fullName)
            let username = try v.usernameTextView.textField.validatedText(validationType: .username)
            let user = UserRegistrationModel(email: email, password: password, fullName: fullName, username: username)
            self.registerUser(user: user)
        } catch let error as ValidationError {
            showAlert(message: error.message)
        } catch {
            showAlert(message: "Something went wrong")
        }
    }
    
    func registerUser(user: UserRegistrationModel) {
        userManager.createUser(user: user) {[weak self] (error) in
            DispatchQueue.main.async {
                guard let weakSelf = self else { return }
                if let error = error {
                    weakSelf.showAlert(message: error.localizedDescription)
                }
                weakSelf.showAlert(message: "Successfully Registered")
            }
        }
    }
    
    func showAlert(message: String) {
        let ac = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Selectors
    @objc func addProfilePicButtonPressed(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func signUpButtonPressed(_ sender: UIButton) {
        validateSignUpFields()
        self.view.endEditing(true)
    }

}

// MARK: - Image Picker Delegate
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.selectedImage = profileImage
        self.registrationView.setProfileImage(profileImage.withRenderingMode(.alwaysOriginal))
        dismiss(animated: true, completion: nil)
    }
}
