//
//  GoogleBooksAPIClient.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

class GoogleBooksAPIClient {
    
    // MARK: - Static Properties
    static let manager = GoogleBooksAPIClient()
    
    // MARK: - Instance Methods
    static func getSearchResultsURLStr(from isbn: String) -> String {
        
        return "https://www.googleapis.com/books/v1/volumes?q=+isbn:\(isbn)"
    }
    
    func getGoogleBooks(urlStr: String, completionHandler: @escaping (Result<[GoogleBook], AppError>) -> ())  {
        
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
                    let googleBooksInfo = try BookWrapper.decodeGoogleBookFromData(from: data)
                    completionHandler(.success(googleBooksInfo))
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
