//
//  NotificationsViewController.swift
//  TwitterClone
//
//  Created by Lawrence on 7/22/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Set background color
        self.view.backgroundColor = .white
        
        // Set navigation bar title
        self.navigationItem.title = "Notifications"
    }
}
