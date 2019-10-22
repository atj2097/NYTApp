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
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 14.0)
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
      let tv = UITextView()
        tv.isScrollEnabled = true
        tv.backgroundColor = .white
        tv.font = UIFont(name: "AmericanTypewriter", size: 13.0)
        tv.textColor = .black
        return tv
    }()
    
    lazy var optionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        button.addTarget(self, action: #selector(optionsButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    @objc func optionsButtonPressed(_ sender: UIButton) {
        delegate?.showActionSheet(tag: sender.tag)
    }
    
    weak var delegate: FavoriteCellDelegate?
    
    //MARK: - Override Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureBookImageContraints()
        configureOptionsButtonContraints()
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
        contentView.addSubview(optionsButton)
    }
    
    // MARK: - Contraint Methods
    private func configureBookImageContraints() {
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        
        [bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0), bookImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), bookImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5), bookImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)].forEach({$0.isActive = true})
    }
    
    private func configureOptionsButtonContraints() {
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        [optionsButton.topAnchor.constraint(equalTo: contentView.topAnchor), optionsButton.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor), optionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), optionsButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25)].forEach({$0.isActive = true})
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
