//
//  GoogleBookModel.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct BookWrapper: Codable {
    let items: [GoogleBook]
    
    static func decodeGoogleBookFromData(from jsonData: Data) throws -> [GoogleBook] {
      let response = try JSONDecoder().decode(BookWrapper.self, from: jsonData)
        return response.items
    }
}

// MARK: - Item
struct GoogleBook: Codable {
    let volumeInfo: VolumeInfo
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let publisher: String
    let publishedDate: String
    let description: String
    let pageCount: Int
    let categories: [String]
    let imageLinks: ImageLinks
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}
