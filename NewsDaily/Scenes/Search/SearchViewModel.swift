//
//  SearchViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 13.12.2022.
//

import Foundation

final class SearchViewModel: SearchViewModelPorotocol {
    weak var delegate: SearchViewDelegate?
    
    //MARK: - Injections
    private var newsService: NewsServiceProtocol
    private weak var coordinator: SearchCoordinatorProtocol?
    
    init(newsService: NewsServiceProtocol, coordinator: SearchCoordinatorProtocol) {
        self.newsService = newsService
        self.coordinator = coordinator
    }
    
    //MARK: - Properties
    private var articles = [Article]()
    
    private var query = ""
    private var nextPage: String? = ""

    //MARK: - Main Functions
    func search(with q: String) {
        print(#function)
        query = q
        notify(.startLoading)
        newsService.searchFor(endPoint: .searchFor(q: query, page: nextPage)) { [weak self] result in
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
        self.articles.append(contentsOf: news.results)
        
        self.nextPage = news.nextPage
        
        self.articles = self.articles.removeDuplicates()

        let articlePresentation = self.articles.map { ArticlePresentation(article: $0) }
        notify(.didUploadWithNews(news: articlePresentation))
        
        checkEmptyState(message: "No results found for \(query)")
    }
    
    func newSearch() {
        query = ""
        articles.removeAll()
        nextPage = ""
    }
    
    func checkEmptyState() {
        checkEmptyState(message: "no_text".localized())
    }
    
    private func checkEmptyState(message: String) {
        if articles.isEmpty {
            notify(.showEmptyStateView(message: message))
        }
        else {
            notify(.removeEmptyStateView)
        }
    }
    
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat) {
        if !articles.isEmpty {
            if height + offset - 50 >= contentHeight {
                if nextPage != nil {
                    search(with: query)
                }
            }
        }
    }
    
    func selectItem(at index: Int) {
        let selectedArticle = articles[index]
        coordinator?.goToDetail(article: selectedArticle)
    }
    
    //MARK: - Helper Functions
    private func notify(_ output: SearchOutputs) {
        delegate?.handleOutputs(output)
    }
}
