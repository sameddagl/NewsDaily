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
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat)
    func didPullToRefresh()
    func selectItem(at index: Int)
}

enum HomeViewModelOutput {
    case startLoading
    case endLoading
    case didUploadWithNews(news: [ArticlePresentation])
    case didFailWithError(title: String, message: String)
}

enum HomeViewModelRoute {
    case detail(viewModel: DetailViewModelProtocol)
}

protocol HomeViewDelegate: AnyObject {
    func handleOutputs(_ output: HomeViewModelOutput)
    func navigate(to route: HomeViewModelRoute)
}
