//
//  FavoritesContracts.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 4.01.2023.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewDelegate? { get set }
    func load()
    func selectItem(at index: Int)
}

enum FavoritesOutput {
    case didUploadWithNews(news: [ArticlePresentation])
    case emptyState(message: String)
    case removeEmptyState
    case didFailWithError(title: String, message: String)
}

protocol FavoritesViewDelegate: AnyObject {
    func handleOutput(_ output: FavoritesOutput)
}
