//
//  SearchContracts.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 13.12.2022.
//

import Foundation

protocol SearchViewModelPorotocol {
    var delegate: SearchViewDelegate? { get set }
    func search(with q: String)
    func newSearch()
    func checkEmptyState()
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat)
    func selectItem(at index: Int)
}

enum SearchOutputs {
    case startLoading
    case endLoading
    case didUploadWithNews(news: [ArticlePresentation])
    case showEmptyStateView(message: String)
    case removeEmptyStateView
    case didFailWithError(title: String, message: String)
}

enum SearchRoute {
    case detail(article: Article)
}

protocol SearchViewDelegate: AnyObject {
    func handleOutputs(_ output: SearchOutputs)
}
