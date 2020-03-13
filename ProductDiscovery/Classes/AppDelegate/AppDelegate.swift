//
//  AppDelegate.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        showScreen()
        return true
    }

}

// MARK: - Navigations

extension AppDelegate {
    
    func showScreen() {
        let productListVC = UIViewController().instantiateViewController(fromStoryboard: .product, ofType: ProductListViewController.self)
        let navProductVC = UINavigationController(rootViewController: productListVC)
        productListVC.navigationController?.isNavigationBarHidden = true
        self.window?.rootViewController = navProductVC
        self.window?.makeKeyAndVisible()
    }
}
