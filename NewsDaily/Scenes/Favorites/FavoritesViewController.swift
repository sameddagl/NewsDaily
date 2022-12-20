//
//  FavoritesViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "favorites_title".localized(with: "")
        view.backgroundColor = .systemBackground
    }
}
