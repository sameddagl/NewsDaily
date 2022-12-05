//
//  NetworkError.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
    case unauthorized
    case unexpectedStatusCode
    case badData
    case decoding
}
