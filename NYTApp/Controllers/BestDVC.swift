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
        var book = UIImageView(frame: .zero)
        book.image = #imageLiteral(resourceName: <#T##String#>)
        return book
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpBookImage()

    }
    
    // MARK: - Contraint Methods
    private func addSubViews() {
        self.view.addSubview(bookImage)
    }
    
    private func setUpBookImage() {
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        [bookImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),bookImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20),bookImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), bookImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25)].forEach({$0.isActive = true})
        
    }
    

}

// MARK: - Extensions

