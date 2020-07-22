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
        self.configureTabBarControllers()
    }
    
    // MARK: - Helper Methods
    func configureTabBarControllers() {
        self.viewControllers = [feedVC, exploreVC, notificationsVC, conversationsVC]
    }
    
    func addNavigationController(with tabBarImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.image = tabBarImage
        navVC.navigationBar.barTintColor = .white
        return navVC
    }

}
