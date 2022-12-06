//
//  HomeViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewDelegate?
    private var newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    private var news = [Article]()
    
    private var selectedCategory: NewsCategories = .general
    private var currentPage = 1
    
    func load() {
        notify(.startLoading)
        newsService.fetchNews(endPoint: NewsEndpoint.fetchNews(category: selectedCategory, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            self.notify(.endLoading)
            switch result {
            case .success(let news):
                self.news.append(contentsOf: news.articles)
                let news = self.news.map{ ArticlePresentation(article: $0) }
                self.notify(.didUploadWithNews(news: news))
            case .failure(let error):
                self.notify(.didFailWithError(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat) {
        if height + offset - 50 >= contentHeight {
            currentPage += 1
            load()
        }
    }

    
    func didPullToRefresh() {
        
    }
    
    func selectItem(at index: Int) {
        //TODO
        let viewModel = DetailViewModel(article: news[index])
        delegate?.navigate(to: .detail(viewModel: viewModel))
    }
    
    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleOutputs(output)
    }
    
    
}
