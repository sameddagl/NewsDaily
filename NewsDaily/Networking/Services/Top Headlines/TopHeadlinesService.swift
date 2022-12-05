//
//  TopHeadlinesService.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

protocol TopHeadlinesServiceProtocol {
    func fetchNews(endPoint: TopHeadlinesEndpoint, completion: @escaping(Result<News, NetworkError>) -> Void)
}

final class TopHeadlinesService: TopHeadlinesServiceProtocol {
    private var service: ServiceProtocol!
    
    init(service: ServiceProtocol!) {
        self.service = service
    }
    
    func fetchNews(endPoint: TopHeadlinesEndpoint, completion: @escaping(Result<News, NetworkError>) -> Void) {
        service.fetch(endPoint: endPoint) { (result: Result<News, NetworkError>) in
            completion(result)
        }
    }

}
