//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by Lawrence on 7/22/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
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
        
        // Set twitter icon on navigation bar
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
