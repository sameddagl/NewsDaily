//
//  SortOption.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 20.12.2022.
//

import Foundation

struct SortOption {
    let title: String
    var isSelected: Bool
    
    static let sorts = [
        SortOption(title: "top".localized(), isSelected: false),
        SortOption(title: "world".localized(), isSelected: false),
        SortOption(title: "business".localized(), isSelected: false),
        SortOption(title: "technology".localized(), isSelected: false),
        SortOption(title: "entartainment".localized(), isSelected: false),
        SortOption(title: "sports".localized(), isSelected: false),
        SortOption(title: "environment".localized(), isSelected: false),
        SortOption(title: "food".localized(), isSelected: false),
        SortOption(title: "health".localized(), isSelected: false),
        SortOption(title: "politics".localized(), isSelected: false),
        SortOption(title: "science".localized(), isSelected: false)
    ]
}
