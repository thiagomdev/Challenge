//
//  ProductAPI.swift
//  Challenge_AfroDev_
//
//  Created by Thiago Monteiro on 11/25/20.
//

import Foundation

// MARK: - Enums
enum ProductAPIError: Error {
    case badUrl
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case decodeError
}






class ProductAPI {
    
    // MARK: - Properties
    private let urlAPI = "https://private-8f4dda-testeabi.apiary-mock.com/produtos"
    private let sessionConfiguration: URLSessionConfiguration = {
        
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 10
        configuration.httpMaximumConnectionsPerHost = 6
        configuration.httpAdditionalHeaders = ["Content-Type" : "application.json"]
        return configuration
    }()
    
    
    
    
    private lazy var  session = URLSession(configuration: sessionConfiguration)
    
    // MARK: - Methods
    func loadProduct(onComplete: @escaping (Result<[ProductABinBev], ProductAPIError>) -> Void) {
        
        
        
    
        
        guard let url = URL(string: urlAPI) else {
            onComplete(.failure(.badUrl))
            return
            
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                onComplete(.failure(.taskError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.noResponse))
                return
            }
            if response.statusCode < 200 || response.statusCode > 299 {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            
            guard let data = data else {
                onComplete(.failure(.noData))
                return
            }
            
            do {
                
                let product = try JSONDecoder().decode([ProductABinBev].self, from: data)
                onComplete(.success(product))
                print(product.count)
                
            } catch {
                onComplete(.failure(.decodeError))
            }
        }
        
        task.resume()
    }
}
