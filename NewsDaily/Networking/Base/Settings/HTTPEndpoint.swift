//
//  HTTPEndpoint.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

protocol HTTPEndpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}


extension HTTPEndpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "newsapi.org"
    }
    
    var method: HTTPMethod {
        return .get
    }
}


