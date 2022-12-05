//
//  HomeViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    var delegate: HomeViewDelegate?
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
                let presentation = self.news.map{ HomePresentation(article: $0) }
                self.notify(.didUploadWithNews(news: presentation))
            case .failure(let error):
                self.notify(.didFailWithError(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    func didPullToRefresh() {
        
    }
    
    func selectItem(at index: Int) {
        //TODO
    }
    
    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleOutputs(output)
    }
    
    
}
