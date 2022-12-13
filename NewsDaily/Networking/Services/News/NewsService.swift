//
//  NewsService.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(endPoint: NewsEndpoint, completion: @escaping(Result<News, NetworkError>) -> Void)
    func searchFor(endPoint: NewsEndpoint, completion: @escaping(Result<News, NetworkError>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    private var service: ServiceProtocol!
    
    init(service: ServiceProtocol!) {
        self.service = service
    }
    
    func fetchNews(endPoint: NewsEndpoint, completion: @escaping(Result<News, NetworkError>) -> Void) {
        service.fetch(endPoint: endPoint) { (result: Result<News, NetworkError>) in
            completion(result)
        }
    }
    
    func searchFor(endPoint: NewsEndpoint, completion: @escaping(Result<News, NetworkError>) -> Void) {
        service.fetch(endPoint: endPoint) { (result: Result<News, NetworkError>) in
            completion(result)
        }
    }

}
