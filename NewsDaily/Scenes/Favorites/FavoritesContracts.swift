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
    func deleteAllTapped()
    func deleteAll()
}

enum FavoritesOutput {
    case didUploadWithNews(news: [ArticlePresentation])
    case isDeleteAllEnabled(isEnabled: Bool)
    case emptyState(message: String)
    case removeEmptyState
    case showAlert
    case didFailWithError(title: String, message: String)
}

protocol FavoritesViewDelegate: AnyObject {
    func handleOutput(_ output: FavoritesOutput)
}
