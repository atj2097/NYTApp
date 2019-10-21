//
//  GoogleBookModel.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
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
