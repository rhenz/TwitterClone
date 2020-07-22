//
//  MainTabViewController.swift
//  TwitterClone
//
//  Created by Lawrence on 7/22/20.
//  Copyright © 2020 JLCS. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    // MARK: - Properties
    var actionButton: UIButton!
    
    // Tabs
    lazy var feedVC: UINavigationController = {
        let vc = FeedViewController()
        let navVC = self.addNavigationController(with: UIImage(named: "home_unselected"), rootViewController: vc)
        return navVC
    }()
    
    lazy var exploreVC: UINavigationController = {
        let vc = ExploreViewController()
        let navVC = self.addNavigationController(with: UIImage(named: "search_unselected"), rootViewController: vc)
        return navVC
    }()
    
    lazy var notificationsVC: UINavigationController = {
        let vc = NotificationsViewController()
        let navVC = self.addNavigationController(with: UIImage(named: "notification_unselected"), rootViewController: vc)
        return navVC
    }()
    
    lazy var conversationsVC: UINavigationController = {
        let vc = ConversationsViewController()
        let navVC = self.addNavigationController(with: UIImage(named: "conversation_unselected"), rootViewController: vc)
        return navVC
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.configureTabBarControllers()
    }
    
    // MARK: - Helper Methods
    func setupView() {
        // Setup action button
        self.actionButton = UIButton(type: .system)
        self.actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionButton.tintColor = .white
        self.actionButton.backgroundColor = .twitterBlue
        self.actionButton.setImage(UIImage(named: "new_tweet"), for: .normal)
        self.actionButton.layer.cornerRadius = 55 / 2
        self.actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(actionButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            self.actionButton.heightAnchor.constraint(equalToConstant: 55),
            self.actionButton.widthAnchor.constraint(equalToConstant: 55),
            self.actionButton.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -10),
            self.actionButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
    }
    
    func configureTabBarControllers() {
        self.viewControllers = [feedVC, exploreVC, notificationsVC, conversationsVC]
    }
    
    func addNavigationController(with tabBarImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.image = tabBarImage
        navVC.navigationBar.barTintColor = .white
        return navVC
    }
    
    @objc
    func actionButtonTapped(_ sender: UIButton) {
        print("Button Tapped")
    }
}
