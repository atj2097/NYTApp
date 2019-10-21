//
//  CategoriesAPIClient.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

class CategoriesAPIClient {
    
    // MARK: - Static Properties
    static let manager = CategoriesAPIClient()
    
    // MARK: - Instance Methods
    static func getSearchResultsURLStr() -> String {
        
        return "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(Secrets.sunniNYTAPIKey)"
    }
    
    func getCategories(urlStr: String, completionHandler: @escaping (Result<[Category], AppError>) -> ())  {
        
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
                    let categoriesInfo = try CategoryWrapper.decodeCategoriesFromData(from: data)
                    completionHandler(.success(categoriesInfo))
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
