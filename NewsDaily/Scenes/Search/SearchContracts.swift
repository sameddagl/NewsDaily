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
    func didPullToRefresh()
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat)
    func selectItem(at index: Int)
}

enum SearchViewModelOutput {
    case startLoading
    case endLoading
    case didUploadWithNews(news: [ArticlePresentation])
    case showEmptyStateView(message: String)
    case removeEmptyStateView
    case didFailWithError(title: String, message: String)
}

enum SearchViewModelRoute {
    case detail(viewModel: DetailViewModelProtocol)
}

protocol SearchViewDelegate: AnyObject {
    func handleOutputs(_ output: SearchViewModelOutput)
    func navigate(to route: SearchViewModelRoute)
}
