//
//  UserDefaultsWrapper.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

//
//  UserModel.swift
//  photoJournal
//
//  Created by God on 10/4/19.
//  Copyright © 2019 God. All rights reserved.
//
import Foundation
import UIKit
class UserDefaultsWrapper {
  
    
    // MARK: - Static Properties
    
    static let manager = UserDefaultsWrapper()
    
    // MARK: - Internal Methods
    //STORE
 
    func storeFavCats(favCat: String) {
        UserDefaults.standard.set(favCat, forKey: favoriteCategory)
    }
    
    
    //GET
    func getFavCats() -> String? {
        return UserDefaults.standard.value(forKey: favoriteCategory) as? String ?? ""
    }


    
    
    
    // MARK: - Private inits and properties
    
    private init() {}

    private let favoriteCategory = "favoriteCategory"
}

