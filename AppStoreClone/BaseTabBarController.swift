//
//  BaseTabBarController.swift
//  AppStoreClone
//
//  Created by krAyon on 18.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .white
        redVC.navigationItem.title = "APPS"
        
        let redNavVC = UINavigationController(rootViewController: redVC)
        redNavVC.tabBarItem.title = "Apps"
        redNavVC.navigationBar.prefersLargeTitles = true
        redNavVC.tabBarItem.image = #imageLiteral(resourceName: "apps")
        
        let blueVC = UIViewController()
        blueVC.view.backgroundColor = .white
        blueVC.navigationItem.title = "Search"
        
        let blueNavVC = UINavigationController(rootViewController: blueVC)
        blueNavVC.tabBarItem.title = "Search"
        blueNavVC.navigationBar.prefersLargeTitles = true
        blueNavVC.tabBarItem.image = #imageLiteral(resourceName: "search")
        
        viewControllers = [
            redNavVC, blueNavVC
        ]
    }
}
