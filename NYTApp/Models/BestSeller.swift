//
//  BestSeller.swift
//  NYTApp
//
//  Created by Sunni Tang on 10/22/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

// MARK: - Books
struct BestSellerWrapper: Codable {
    let results: Results
    
    static func decodeBestSellerFromData(from jsonData: Data) throws -> [BestSeller] {
        let response = try JSONDecoder().decode(BestSellerWrapper.self, from: jsonData)
        return response.results.books
    }
}

// MARK: - Results
struct Results: Codable {
    let listName, listNameEncoded: String
    let displayName: String
    let books: [BestSeller]
    
    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case displayName = "display_name"
        case books
    }
    
    
}

// MARK: - Book
struct BestSeller: Codable {
    let rank, weeksOnList: Int
    let publisher, bookDescription: String
    let price: Int
    let title, author: String
    let bookImage: String
    let bookImageWidth, bookImageHeight: Int
    let amazonProductURL: String

    enum CodingKeys: String, CodingKey {
        case rank
        case weeksOnList = "weeks_on_list"
        case publisher
        case bookDescription = "description"
        case price, title, author
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case amazonProductURL = "amazon_product_url"
    }
}
