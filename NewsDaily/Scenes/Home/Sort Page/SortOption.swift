//
//  SortOption.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 20.12.2022.
//

import Foundation

struct SortOption {
    let title: String
    let category: NewsCategories
    
    static let sorts = [
        SortOption(title: "top".localized(), category: .top),
        SortOption(title: "world".localized(), category: .world),
        SortOption(title: "business".localized(), category: .business),
        SortOption(title: "technology".localized(), category: .technology),
        SortOption(title: "entartainment".localized(), category: .entertainment),
        SortOption(title: "sports".localized(), category: .sports),
        SortOption(title: "environment".localized(), category: .environment),
        SortOption(title: "food".localized(), category: .food),
        SortOption(title: "health".localized(), category: .health),
        SortOption(title: "politics".localized(), category: .politics),
        SortOption(title: "science".localized(), category: .science)
    ]
}
