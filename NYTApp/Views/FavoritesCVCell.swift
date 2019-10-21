//
//  FavoritesCVCell.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class FavoritesCVCell: UICollectionViewCell {
    // MARK: - UI Objects
    lazy var bookImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
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
    
    lazy var optionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        return button
    }()
    
    //MARK: - Override Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
