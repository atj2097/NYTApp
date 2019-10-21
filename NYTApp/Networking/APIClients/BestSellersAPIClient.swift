//
//  BestSellersAPIClient.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

class BestSellersAPIClient {
    
    // MARK: - Static Properties
    static let manager = BestSellersAPIClient()
    
    // MARK: - Instance Methods
    static func getSearchResultsURLStr(from category: String) -> String {
        
        return "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(Secrets.sunniNYTAPIKey)&list=\(category)"
    }
    
    func getBestSellers(urlStr: String, completionHandler: @escaping (Result<[BestSeller], AppError>) -> ())  {
        
        guard let url = URL(string: urlStr) else {
            print(AppError.badURL)
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let bestSellerInfo = try BestSellerWrapper.decodeBestSellerFromData(from: data)
                    completionHandler(.success(bestSellerInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    // MARK: - Private Properties and Initializers
    private init() {}
}
