//
//  MainTabBarController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 14.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let listViewController = ListViewController()
    let peopleViewController = PeopleViewController()
    
    let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let conversImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        tabBar.tintColor = #colorLiteral(red: 0.5304797292, green: 0.2621831894, blue: 0.5647147298, alpha: 1)
        
        viewControllers = [
            generateNavController(rootViewController: listViewController, title: "Chats", image: conversImage),
            generateNavController(rootViewController: peopleViewController, title: "People", image: peopleImage)
        ]
        
    }

    private func generateNavController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

