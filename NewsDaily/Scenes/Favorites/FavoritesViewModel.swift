//
//  FavoritesViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 4.01.2023.
//

import Foundation

final class FavoritesViewModel: FavoritesViewModelProtocol {
    weak var delegate: FavoritesViewDelegate?
    
    //MARK: - Injections
    private let coreDataManager: CoreDataManagerProtocol
    private let coordinator: FavoritesCoordinatorProtocol
    
    init(coreDataManager: CoreDataManagerProtocol, coordinator: FavoritesCoordinatorProtocol) {
        self.coreDataManager = coreDataManager
        self.coordinator = coordinator
    }
    
    //MARK: - Properties
    private var savedArticles = [NewsModel]()
    
    //MARK: - Main Functions
    func load() {
        savedArticles = coreDataManager.fetchSavedNews()
        if savedArticles.isEmpty {
            notify(.didUploadWithNews(news: []))
            notify(.emptyState(message: "no_saved_article".localized()))
            return
        }
        
        notify(.didUploadWithNews(news: savedArticles.map { ArticlePresentation(article: $0) }))
        notify(.removeEmptyState)
    }
    
    func selectItem(at index: Int) {
        let selectedArticle = savedArticles[index]
        
        coordinator.goToDetail(article: Article(title: selectedArticle.title!,
                                                link: selectedArticle.link!,
                                                description: selectedArticle.descript,
                                                image_url: selectedArticle.imageURL,
                                                source_id: selectedArticle.source_id!))
    }
    
    func deleteAll() {
        coreDataManager.deleteAll()
        load()
    }
    
    //MARK: - Helper Functions
    private func notify(_ output: FavoritesOutput) {
        delegate?.handleOutput(output)
    }
}
