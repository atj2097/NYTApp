//
//  BestSellerCVCell.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class BestSellerCVCell: UICollectionViewCell {
    
    // MARK: - UI Objects
    lazy var bookImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
      let tv = UITextView()
        tv.isScrollEnabled = true
        tv.backgroundColor = .white
        tv.textColor = .black
        return tv
    }()
    
    // MARK: -
}
