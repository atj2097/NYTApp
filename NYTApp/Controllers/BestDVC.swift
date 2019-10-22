//
//  BestDVC.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class BestDVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var bookImage: UIImageView = {
        var imageView = UIImageView()
        loadImage(imageView: imageView)
        return imageView
    }()
    
    lazy var descriptionTextField: UITextView = {
        let textField = UITextView(frame: .zero)
        textField.text = selectedBestSeller.bookDescription
        textField.textColor = .black
        textField.isScrollEnabled = true
        textField.font = UIFont.init(name: "ArialMT", size: 12)
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        return textField
    }()
    
    lazy var amazonIcon: UIButton = {
        var amazonIcon = UIButton(frame: .zero)
        amazonIcon.setBackgroundImage(UIImage(named: "amazon-512"), for: .normal)
        amazonIcon.backgroundColor = .clear
        amazonIcon.addTarget(self, action: #selector(amazonLink), for: .touchUpInside)
        return amazonIcon
    }()
    
    // MARK: - Internal Properties
    var selectedBestSeller: BestSeller!
    
    
    // MARK: - Private Functions
    private func loadImage(imageView: UIImageView) {
        let imageURLStr = selectedBestSeller.bookImage
        
        ImageHelper.shared.getImage(urlStr: imageURLStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromURL):
                    imageView.image = imageFromURL
                }
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpBookImage()
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addToFavorites))
        let add = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.title = selectedBestSeller.title
    }
    
    //MARK: - Objective C Functions
    
    @objc func addToFavorites() {
        do {
            try BestSellerPersistenceManager.manager.saveSeller(seller: selectedBestSeller)
        } catch {
            print(error)
        }

    }
    
    @objc func amazonLink() {
        
    }
    
    // MARK: - Contraint Methods
    private func addSubViews() {
        self.view.addSubview(bookImage)
        self.view.addSubview(descriptionTextField)
        self.view.addSubview(amazonIcon)
    }
    
    private func setUpBookImage() {
        //Book Image
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        [bookImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),bookImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), bookImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.40), bookImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75)].forEach({$0.isActive = true})
        
        //Text Field
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        [descriptionTextField.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 20),descriptionTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),descriptionTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 45),descriptionTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0)].forEach({$0.isActive = true})
        
        //Button
        amazonIcon.translatesAutoresizingMaskIntoConstraints = false
        [amazonIcon.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 675),amazonIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),amazonIcon.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),amazonIcon.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
        
    }
    
    
}

// MARK: - Extensions

