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
        iv.layer.cornerRadius = 15
        iv.backgroundColor = .red
        return iv
    }()
    
    lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 14.0)
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
      let tv = UITextView()
        tv.font = UIFont(name: "AmericanTypewriter", size: 13.0)
        tv.isScrollEnabled = true
        tv.backgroundColor = .white
        tv.textColor = .black
        return tv
    }()
    
    //MARK: - Override Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureBookImageContraints()
        configureListLabelContraints()
        configureDescriptionTextViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        contentView.addSubview(bookImage)
        contentView.addSubview(weeksOnListLabel)
        contentView.addSubview(descriptionTextView)
    }
    
    // MARK: - Contraint Methods
    private func configureBookImageContraints() {
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        
        [bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0), bookImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), bookImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5), bookImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)].forEach({$0.isActive = true})
    }
    
    private func configureListLabelContraints() {
        weeksOnListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [weeksOnListLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor), weeksOnListLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), weeksOnListLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), weeksOnListLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)].forEach({$0.isActive = true})
    }
    
    private func configureDescriptionTextViewContraints() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        [descriptionTextView.topAnchor.constraint(equalTo: weeksOnListLabel.bottomAnchor), descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)].forEach({$0.isActive = true})
    }
}
