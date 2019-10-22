//
//  FavoritesPersistenceHelper.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

//
import Foundation

struct BestSellerPersistenceManager {
    private init() {}
    static let manager = BestSellerPersistenceManager()
    
    private let persistenceHelper = PersistenceHelper<BestSeller>(fileName: "bestseller.plist")
    
    func saveSeller(seller: BestSeller) throws {
        try persistenceHelper.save(newElement: seller)

    }
    
    func delete(tag: Int) throws {
        try persistenceHelper.delete(index: tag)
    }

    func getSellers() throws -> [BestSeller] {
        return try persistenceHelper.getObjects()
    }

}
