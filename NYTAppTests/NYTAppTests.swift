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
            
}
