//
//  NYTAppTests.swift
//  NYTAppTests
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import XCTest
@testable import NYTApp

class NYTAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBestSellerModelData() {
        // Arrange
        guard let jsonPath = Bundle.main.path(forResource: "BestSellerJSON", ofType: "json") else {
            XCTFail("Could not find BestSellerJSON file")
            return
        }
        
        let jsonURL = URL(fileURLWithPath: jsonPath)
        var bestSellerJSONData = Data()
        
        do {
            bestSellerJSONData = try Data(contentsOf: jsonURL)
        } catch {
            XCTFail("\(error)")
        }
        
        // Act
        var bestSellers = [BestSeller]()
        
        do {
            let bestSellersInfo = try BestSellerWrapper.decodeBestSellerFromData(from: bestSellerJSONData)
            bestSellers = bestSellersInfo
        } catch {
            XCTFail("\(error)")
        }
        
        // Assert
        XCTAssertTrue(bestSellers.count == 15, "Was expecting 15 best sellers, but found \(bestSellers.count)")
    }
    
    func testCategoryModelData() {
        // Arrange
        guard let jsonPath = Bundle.main.path(forResource: "CategoryJSON", ofType: "json") else {
            XCTFail("Could not find CategoryJSON file")
            return
        }
        
        let jsonURL = URL(fileURLWithPath: jsonPath)
        var categoryJSONData = Data()
        
        do {
            categoryJSONData = try Data(contentsOf: jsonURL)
        } catch {
            XCTFail("\(error)")
        }
        
        // Act
        var categories = [Category]()
        
        do {
            let categoriesInfo = try CategoryWrapper.decodeCategoriesFromData(from: categoryJSONData)
            categories = categoriesInfo
        } catch {
            XCTFail("\(error)")
        }
        
        // Assert
        XCTAssertTrue(categories.count == 59, "Was expecting 59 best sellers, but found \(categories.count)")
    }
        
    func g() {
        // Arrange
        guard let jsonPath = Bundle.main.path(forResource: "GoogleBookJSON", ofType: "json") else {
            XCTFail("Could not find GoogleBookJSON file")
            return
        }
        
        let jsonURL = URL(fileURLWithPath: jsonPath)
        var googleBookJSONData = Data()
        
        do {
            googleBookJSONData = try Data(contentsOf: jsonURL)
        } catch {
            XCTFail("\(error)")
        }
        
        // Act
        var googleBooks = [GoogleBook]()
        
        do {
            let googleBookInfo = try BookWrapper.decodeGoogleBookFromData(from: googleBookJSONData)
            googleBooks = googleBookInfo
        } catch {
            XCTFail("\(error)")
        }
        
        // Assert
        XCTAssertTrue(googleBooks.count == 1, "Was expecting 1 google book info, but found \(googleBooks.count)")
    }
}
