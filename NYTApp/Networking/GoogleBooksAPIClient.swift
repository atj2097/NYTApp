//
//  GoogleBooksAPIClient.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

final class GoogleBooksAPIClient {
    
    private init() {}
    
    public static func getGoogleBooks(category: String, completionHandler: @escaping (AppError?, [Item]?) -> Void) {
        let URL = "https://www.googleapis.com/books/v1/volumes?q=\(Secrets.sunniGoogleAPIKey)"
        
        NetworkHelper.manager.performDataTask(withUrl: URL, andMethod: HTTPMethod, completionHandler: ((Result<Data, AppError>) -> ()) ) { (AppError, data) in
            
            if let AppError = appError {
                
                completionHandler(appError, nil)
                
            } else if let data = data {
                
                do {
                    
                    let items = try JSONDecoder().decode([Item].Welcome.self, from: data)
                    
                    completionHandler(nil, items.results)
                    
                } catch {
                    
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
}
