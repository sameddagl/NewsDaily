//
//  Coordinator.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
