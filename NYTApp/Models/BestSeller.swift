//
//  BestSellerModel.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

// MARK: - BestSellerWrapper
struct BestSellerWrapper: Codable {
    let results: [BestSeller]
    
    static func decodeBestSellerFromData(from jsonData: Data) throws -> [BestSeller] {
        let response = try JSONDecoder().decode(BestSellerWrapper.self, from: jsonData)
        return response.results
    }

}

// MARK: - BestSeller
struct BestSeller: Codable {
    let listName: String
    let rank: Int
    let weeksOnList: Int
    let amazonProductURL: String
    let bookDetails: [BookDetail]

    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case rank
        case weeksOnList = "weeks_on_list"
        case amazonProductURL = "amazon_product_url"
        case bookDetails = "book_details"
    }
}

// MARK: - BookDetail
struct BookDetail: Codable {
    let title: String
    let bookDetailDescription: String
    let author: String
    let price: Int
    let publisher: String
    let primaryIsbn10: String

    private enum CodingKeys: String, CodingKey {
        case title
        case bookDetailDescription = "description"
        case author
        case price
        case publisher
        case primaryIsbn10 = "primary_isbn10"
    }
}
