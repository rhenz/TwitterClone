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
    lazy var feedVC: FeedViewController = {
        let vc = FeedViewController()
        vc.tabBarItem.image = UIImage(named: "home_unselected")
        return vc
    }()
    
    lazy var exploreVC: ExploreViewController = {
        let vc = ExploreViewController()
        vc.tabBarItem.image = UIImage(named: "search_unselected")
        return vc
    }()
    
    lazy var notificationsVC: NotificationsViewController = {
        let vc = NotificationsViewController()
        vc.tabBarItem.image = UIImage(named: "notification_unselected")
        return vc
    }()
    
    lazy var conversationsVC: ConversationsViewController = {
        let vc = ConversationsViewController()
        vc.tabBarItem.image = UIImage(named: "conversation_unselected")
        return vc
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewControllers()
    }
    
    // MARK: - Helper Methods
    func configureViewControllers() {
        self.viewControllers = [feedVC, exploreVC, notificationsVC, conversationsVC]
    }

}
