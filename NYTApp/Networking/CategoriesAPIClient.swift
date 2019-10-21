//
//  CategoriesAPIClient.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

final class NYTCategoriesAPIClient {
    
static func getCategories(completionHandler: @escaping (AppError?, [Category]?) -> Void) {
    
    let URL =
    
    "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(Secrets.sunniNYTAPIKey)"
    
    NetworkHelper.manager.performDataTask(withUrl: URL) { (AppError, Data) in
        if let AppError = AppError {
        
            completionHandler(AppError, nil)
            
        } else if let data = Data {
            
            do {
                let categoryData = try JSONDecoder().decode(Category.CategoryWrapper.self, from: data)
                
                completionHandler(nil, categoryData.results)
                
            } catch {
                
                completionHandler(AppError.jsonDecodingErorr(error), nil)
            }
        }
        
    }
}
}
