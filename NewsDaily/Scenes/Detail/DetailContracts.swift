//
//  DetailContracts.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var delegate: DetailViewDelagate? { get set }
    func load()
    func saveTapped(isSelected: Bool)
    func requestWebPage()
}

enum DetaiViewModelOutput {
    case load(ArticlePresentation)
    case isSaved(Bool)
    case showSafariView(url: String)
}

protocol DetailViewDelagate: AnyObject {
    func handleOutput(_ output: DetaiViewModelOutput)
}
