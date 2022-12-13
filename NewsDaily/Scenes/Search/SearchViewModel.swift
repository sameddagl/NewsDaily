//
//  SearchViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 13.12.2022.
//

import Foundation

final class SearchViewModel: SearchViewModelPorotocol {
    weak var delegate: SearchViewDelegate?
    
    private var newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    private var articles = [Article]()
    
    private var query = ""
    private var currentPage = 1
    private var hasMoreNews = true
    
    func search(with q: String) {
        query = q
        notify(.startLoading)
        newsService.searchFor(endPoint: .searchFor(q: query, page: currentPage)) { [weak self] result in
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
        if news.results.count <= 0 {
            self.hasMoreNews = false
        }
        else {
            self.hasMoreNews = true
        }
        
        self.articles.append(contentsOf: news.results)
        let articlePresentation = self.articles.map { ArticlePresentation(article: $0) }
        self.notify(.didUploadWithNews(news: articlePresentation))
        
        if articles.isEmpty {
            notify(.showEmptyStateView(message: "No results found for \(query)"))
        }
        else {
            notify(.removeEmptyStateView)
        }
    }
    
    func newSearch() {
        articles.removeAll()
        currentPage = 1
    }
    
    func didPullToRefresh() {
        articles.removeAll()
        currentPage = 1
        search(with: query)
    }
    
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat) {
        if height + offset - 50 >= contentHeight {
            if hasMoreNews {
                currentPage += 1
                search(with: query)
            }
        }
    }
    
    func selectItem(at index: Int) {
        let selectedArticle = articles[index]
        let viewModel = DetailViewModel(article: selectedArticle)
        delegate?.navigate(to: .detail(viewModel: viewModel))
    }
    
    private func notify(_ output: SearchViewModelOutput) {
        delegate?.handleOutputs(output)
    }
    
    
}
