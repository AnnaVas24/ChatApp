//
//  MainTabBarController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 14.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    let currentUser: MUser
    init(currentUser: MUser = MUser(
        username: "BUBU",
        avatarStringURL: "BUBU",
        id: "BUBU",
        email: "BUBU",
        description: "BUBU",
        gender: "BUBU"
    )) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        
        let conversImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        tabBar.tintColor = #colorLiteral(red: 0.5304797292, green: 0.2621831894, blue: 0.5647147298, alpha: 1)
        
        viewControllers = [
            generateNavController(rootViewController: peopleViewController, title: "People", image: peopleImage),
            generateNavController(rootViewController: listViewController, title: "Chats", image: conversImage)
        ]
        
    }

    private func generateNavController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

