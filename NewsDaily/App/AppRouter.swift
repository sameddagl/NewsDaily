//
//  AppRouter.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

final class AppRouter {
    var window: UIWindow?
    
    init(window: UIWindow? = nil) {
        self.window = window
    }
    
    func start() {
        let tabBarVC = UITabBarController()
        
        UITabBar.appearance().tintColor = .label
        UINavigationBar.appearance().tintColor = .label
        
        let homeScreen = HomeBuilder.make()
        homeScreen.tabBarItem = UITabBarItem(title: "", image: SFSymbols.home, selectedImage: SFSymbols.homeFill)
        let searchScreen = UINavigationController(rootViewController: SearchViewController())
        searchScreen.tabBarItem = UITabBarItem(title: "", image: SFSymbols.search, selectedImage: nil)
        let favoritesScreen = UINavigationController(rootViewController: FavoritesViewController())
        favoritesScreen.tabBarItem = UITabBarItem(title: "", image: SFSymbols.favorites, selectedImage: SFSymbols.favoritesFill)
        
        tabBarVC.setViewControllers([homeScreen, searchScreen, favoritesScreen], animated: true)
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}
