//
//  TabBarVC.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    let searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
    let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .label
        UINavigationBar.appearance().tintColor = .label
        
        let homeScreen = homeCoordinator.navigationController
        homeScreen.tabBarItem = UITabBarItem(title: "", image: SFSymbols.home, selectedImage: SFSymbols.homeFill)
        
        let searchScreen = searchCoordinator.navigationController
        searchScreen.tabBarItem = UITabBarItem(title: "", image: SFSymbols.search, selectedImage: nil)
        
        let favoritesScreen = favoritesCoordinator.navigationController
        favoritesScreen.tabBarItem = UITabBarItem(title: "", image: SFSymbols.favorites, selectedImage: SFSymbols.favoritesFill)
        
        homeCoordinator.start()
        searchCoordinator.start()
        favoritesCoordinator.start()
        
        setViewControllers([homeScreen, searchScreen, favoritesScreen], animated: true)
    }
}
