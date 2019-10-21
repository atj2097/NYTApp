//
//  CategoriesAPIClient.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

final class CategoriesAPIClient {
    private init() {}
    
    static func getAllCategories(completionHandler: @escaping (AppError?, [Category]?) -> Void) {
        let endpointURLString = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(Secrets.key)"
        NetworkHelper.manager.performDataTask(endpointURLString: endpointURLString) { (appError, data) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let categoryData = try JSONDecoder().decode(Category.CategoryData.self, from: data)
                    completionHandler(nil, categoryData.results)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
    
}
