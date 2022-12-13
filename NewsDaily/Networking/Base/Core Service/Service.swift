//
//  Service.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

protocol ServiceProtocol {
    func fetch<T: Decodable>(endPoint: HTTPEndpoint, completion: @escaping(Result<T, NetworkError>) -> Void)
}

final class Service: ServiceProtocol {
    private var cache = NSCache<NSString, UIImage>()
    
    func fetch<T: Decodable>(endPoint: HTTPEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.host
        components.path = endPoint.path
        components.queryItems = endPoint.params
        
        guard let url = components.url else {
            completion(.failure(.badURL))
            return
        }
        
        print(url)
                        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.badURL))
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                }
                catch {
                    print(error)
                    completion(.failure(.decoding))
                }
            case 401:
                completion(.failure(.unauthorized))
            default:
                print(response.statusCode)
                completion(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
}
