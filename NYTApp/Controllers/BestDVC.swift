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
        textField.text =
            """
            #\(selectedBestSeller.rank) on Best Seller's List
            
            \(selectedBestSeller.title)
            By \(selectedBestSeller.author)
            
            \(selectedBestSeller.bookDescription)
            """
        textField.textColor = .black
        textField.isScrollEnabled = true
        textField.font = UIFont.init(name: "ArialMT", size: 20)
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        return textField
    }()
    
    lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Purchase"
        button.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(purchaseBook), for: .touchUpInside)
        return button
    }()
    
    lazy var amazonIcon: UIButton = {
        var amazonIcon = UIButton(frame: .zero)
        amazonIcon.setBackgroundImage(UIImage(named: "amazon-512"), for: .normal)
        amazonIcon.backgroundColor = .clear
        amazonIcon.addTarget(self, action: #selector(amazonLink), for: .touchUpInside)
        return amazonIcon
    }()
    
    lazy var saveFavoriteButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain , target: self, action: #selector(addToFavorites))
        return barButton
    }()
    
    // MARK: - Internal Properties
    var selectedBestSeller: BestSeller!

    lazy var saveFavoritesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Favorites", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addToFavorites))
        return button
    }()
    
    
    // MARK: -Properties
    var detailBook: BestSeller!

    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addSubViews()
        setBookImageViewConstraints()
    }
    
    
    // MARK: - Private Functions
    private func configureViewController() {
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = saveFavoriteButton
        navigationItem.title = selectedBestSeller.title
    }
    
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
    
    //MARK: - Objective C Functions
    
    @objc func addToFavorites() {
        do {
            try BestSellerPersistenceManager.manager.saveSeller(seller: selectedBestSeller)
            print("saved")
        } catch {
            print(error)
        }
    }
    
    @objc func amazonLink() {
        if let url = NSURL(string: selectedBestSeller.amazonProductURL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @objc func purchaseBook() {
        let checkoutVC = CheckoutViewController()
        checkoutVC.modalPresentationStyle = .fullScreen
        self.present(checkoutVC, animated: true, completion: nil)
    }

    // MARK: - Contraint Methods
    private func addSubViews() {
        self.view.addSubview(bookImage)
        self.view.addSubview(descriptionTextField)
        self.view.addSubview(amazonIcon)
        self.view.addSubview(paymentButton)
    }
    
    private func setBookImageViewConstraints() {
        //Book Image
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        [bookImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),bookImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), bookImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.40), bookImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75)].forEach({$0.isActive = true})
        
        //Text Field
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        [descriptionTextField.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 20),descriptionTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),descriptionTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 45),descriptionTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0)].forEach({$0.isActive = true})
        
        //Button
        amazonIcon.translatesAutoresizingMaskIntoConstraints = false
        [amazonIcon.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5),amazonIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),amazonIcon.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),amazonIcon.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
        
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        [paymentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),paymentButton.widthAnchor.constraint(equalToConstant: 150),paymentButton.heightAnchor.constraint(equalToConstant: 50),paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach({$0.isActive = true})
        
    }
    
    
}

// MARK: - Extensions

