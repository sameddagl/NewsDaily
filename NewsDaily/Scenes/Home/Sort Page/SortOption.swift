//
//  SortOption.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 20.12.2022.
//

import Foundation
import UIKit.UIImage

struct SortOption {
    let title: String
    let image: UIImage?
    let category: NewsCategories
    
    static let sorts = [
        SortOption(title: "top".localized(), image: Images.top, category: .top),
        SortOption(title: "world".localized(),image: Images.world, category: .world),
        SortOption(title: "business".localized(), image: Images.business, category: .business),
        SortOption(title: "technology".localized(), image: Images.technology, category: .technology),
        SortOption(title: "Entertainment".localized(), image: Images.entartainment, category: .entertainment),
        SortOption(title: "sports".localized(),image: Images.sports, category: .sports),
        SortOption(title: "environment".localized(), image: Images.environment, category: .environment),
        SortOption(title: "food".localized(), image: Images.food, category: .food),
        SortOption(title: "health".localized(), image: Images.health, category: .health),
        SortOption(title: "politics".localized(), image: Images.politics, category: .politics),
        SortOption(title: "science".localized(), image: Images.science, category: .science)
    ]
}
