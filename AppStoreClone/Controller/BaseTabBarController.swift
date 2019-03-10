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
        
        viewControllers = [
            createNavVC(viewController: TodayVC(), title: "Today", imageName: "today"),
            createNavVC(viewController: AppsPageVC(), title: "Apps", imageName: "apps"),
            createNavVC(viewController: AppsSearchVC(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavVC(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.prefersLargeTitles = true
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = UIImage(named: imageName)
        return navVC
    }
}
