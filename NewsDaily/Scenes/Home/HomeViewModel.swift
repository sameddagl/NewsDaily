//
//  HomeViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewDelegate?
    
    //MARK: - Injections
    private var newsService: NewsServiceProtocol
    private var coordinator: HomeCoordinatorProtocol
    
    init(newsService: NewsServiceProtocol, coordinator: HomeCoordinatorProtocol) {
        self.newsService = newsService
        self.coordinator = coordinator
    }
    
    //MARK: - Properties
    private var news = [Article]()
    private var selectedCategory: NewsCategories = .top
    private var didPullToRefreshPage = false
    private var nextPage: String? = ""
    
    //MARK: - Main Functions
    func load() {
        if !didPullToRefreshPage {
            notify(.startLoading)
        }
        
        newsService.fetchNews(endPoint: .fetchNews(category: selectedCategory, page: nextPage)) { [weak self] result in
            guard let self = self else { return }
            self.notify(.endLoading)
            switch result {
            case .success(let news):
                self.updateData(with: news)
            case .failure(let error):
                self.notify(.didFailWithError(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    private func updateData(with news: News) {
        self.news.append(contentsOf: news.results)
        self.nextPage = news.nextPage
        
        self.news = self.news.removeDuplicates()
        
        let news = self.news.map{ ArticlePresentation(article: $0) }
        self.notify(.didUploadWithNews(news: news))
        
        if self.news.isEmpty {
            notify(.emptyState(message: "no_news".localized()))
            return
        }
        else {
            notify(.removeEmptyState)
        }
    }
    
    func changeCategory(category: NewsCategories) {
        news.removeAll()
        nextPage = ""
        selectedCategory = category
        load()
        notify(.changeCategory)
    }

    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat) {
        if height + offset - 50 >= contentHeight {
            if nextPage != nil {
                load()
            }
        }
    }
    
    func didPullToRefresh() {
        news.removeAll()
        nextPage = ""
        didPullToRefreshPage = true
        load()
        didPullToRefreshPage = false
    }
    
    func didSelectToSort() {
        navigate(to: .sort)
    }
    
    func selectItem(at index: Int) {
        let selectedArticle = news[index]
        navigate(to: .detail(article: selectedArticle))
    }
    
    //MARK: - Helper Functions
    private func navigate(to route: HomeRoute) {
        switch route {
        case .detail(let article):
            coordinator.goToDetail(article: article)
        case .sort:
            coordinator.goToSort(delegate: self)
        }
    }

    private func notify(_ output: HomeOutput) {
        delegate?.handleOutputs(output)
    } 
}

//MARK: - Sort View Delegate
extension HomeViewModel: SortViewDelegate {
    func didSelectCategory(category: NewsCategories) {
        changeCategory(category: category)
    }
}
