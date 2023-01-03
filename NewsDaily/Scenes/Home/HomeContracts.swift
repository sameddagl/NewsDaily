//
//  HomeContracts.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewDelegate? { get set }
    func load()
    func selectItem(at index: Int)
    func changeCategory(category: NewsCategories)
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat)
    func didPullToRefresh()
    func didSelectToSort()
}

enum HomeViewModelOutput {
    case startLoading
    case endLoading
    case didUploadWithNews(news: [ArticlePresentation])
    case changeCategory
    case emptyState(message: String)
    case removeEmptyState
    case didFailWithError(title: String, message: String)
}

enum HomeViewModelRoute {
    case detail(article: Article)
    case sort
}

protocol HomeViewDelegate: AnyObject {
    func handleOutputs(_ output: HomeViewModelOutput)
}
