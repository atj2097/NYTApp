//
//  CategoriesModel.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

// MARK: - CategoryWrapper
struct CategoryWrapper: Codable {
    let results: [Category]
    
    static func decodeCategoriesFromData(from jsonData: Data) throws -> [Category] {
        let response = try JSONDecoder().decode(CategoryWrapper.self, from: jsonData)
        return response.results
      }
}

// MARK: - Category
struct Category: Codable {
    let listName: String
    let listNameEncoded: String

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
    }
}
