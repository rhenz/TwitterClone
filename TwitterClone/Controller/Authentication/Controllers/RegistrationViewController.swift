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
    
    private let imagePicker = UIImagePickerController()
    
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
        self.registrationView.didLoginButtonPressed = { sender in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.registrationView.didProfilePicButtonPressed = { sender in
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Selectors

}

// MARK: - Image Picker Delegate
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.registrationView.setProfileImage(profileImage.withRenderingMode(.alwaysOriginal))
        dismiss(animated: true, completion: nil)
    }
}
