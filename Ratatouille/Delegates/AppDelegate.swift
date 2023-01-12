//
//  AppDelegate.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 16, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationBarAppearance.backgroundColor = UIColor.white
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            
            
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        
        // iOS 16.0 UITabBar appearance
        if #available(iOS 16, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithTransparentBackground()
            tabBarAppearance.backgroundColor = .white
            UITabBar.appearance().tintColor = UIColor(named: "PrimaryColor")
            UITabBar.appearance().standardAppearance = tabBarAppearance
            
            #if swift(>=5.5)
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            #endif
        } else {
            UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().tintColor = UIColor(named: "PrimaryColor")
        }
        
        // Color in text in search bar
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

