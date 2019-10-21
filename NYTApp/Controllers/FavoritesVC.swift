//
//  FavoritesVC.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var favoritesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame:.zero , collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 250, height: 250)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cv.register(FavoritesCVCell.self, forCellWithReuseIdentifier: "FavoritesCVCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    // MARK: Properties
    var faveBookImageAndDescrip = [GoogleBook]()
    var faveBookWeeksOnlist = [BestSeller]()
    
    // MARK: -Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureCVContraints()
    }
    
    // MARK: - private Methods
    private func addSubViews() {
        self.view.addSubview(favoritesCV)
        
    }
    
    // MARK: - Contraint Methods
    private func configureCVContraints() {
        favoritesCV.translatesAutoresizingMaskIntoConstraints = false
        [favoritesCV.topAnchor.constraint(equalTo: self.view.topAnchor),favoritesCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),favoritesCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),favoritesCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)].forEach({$0.isActive = true})
        
    }
    

   
}

// MARK: - Extensions
extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCV.dequeueReusableCell(withReuseIdentifier: "FavoritesCVCell", for: indexPath) as? FavoritesCVCell
        cell?.backgroundColor = .red
        return cell!
    }
    
    
}

extension FavoritesVC: FavoriteCellDelegate {
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an option below", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            let deletedImageAndDescription = self.faveBookImageAndDescrip[tag]
            let deletedWeeksOnList = self.faveBookWeeksOnlist[tag]
            
            // TODO: - Use persistence and eliminate print statement
            print("I just deleted \(deletedImageAndDescription) and \(deletedWeeksOnList)")
        }
        
        let seeOnAmazonAction = UIAlertAction.init(title: "See on Amazon", style: .default) { (action) in
            // TODO: - Research how to segue to amazons site
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(seeOnAmazonAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
    
    
}
