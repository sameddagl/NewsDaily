//
//  CoreDataManager.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 3.01.2023.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func save(article: Article)
    func fetchSavedNews() -> [NewsModel]
    func deleteSavedArticle()
}

final class CoreDataManager: CoreDataManagerProtocol {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(article: Article) {
        let savedArticle = NewsModel(context: context)
        
        savedArticle.title = article.title
        savedArticle.descript = article.description
        savedArticle.imageURL = article.image_url
        savedArticle.link = article.link
        savedArticle.source_id = article.source_id
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchSavedNews() -> [NewsModel] {
        var news = [NewsModel]()
        
        do {
            news = try context.fetch(NewsModel.fetchRequest())
            return news
        } catch {
            return []
        }
    }
    
    func deleteSavedArticle() {
        
    }
}
