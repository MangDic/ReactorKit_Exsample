//
//  AppDelegate.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let rootViewController = UINavigationController()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return false }
    
        window.rootViewController = AppDelegate.rootViewController
        let vc = ReactorViewController() // ViewController()
        AppDelegate.rootViewController.pushViewController(vc, animated: false)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        return true
    }
}

