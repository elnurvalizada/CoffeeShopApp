//
//  TabBarController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 02.06.24.
//


import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let scanPayVC = ScanPayViewController()
        scanPayVC.tabBarItem = UITabBarItem(title: "Scan / Pay", image: UIImage(systemName: "qrcode.viewfinder"), tag: 1)
        
        let otherVC = OrderViewController()
        otherVC.tabBarItem = UITabBarItem(title: "Other", image: UIImage(systemName: "cup.and.saucer.fill"), tag: 2)
        
        let accountVC = ProfileViewController()
        accountVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        let viewControllers = [
            CustomNavigationController(rootViewController: homeVC),
            CustomNavigationController(rootViewController: scanPayVC),
            CustomNavigationController(rootViewController: otherVC),
            CustomNavigationController(rootViewController: accountVC)
        ]
        
        self.viewControllers = viewControllers
    }
}
