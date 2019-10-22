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
        layout.itemSize = CGSize(width: 300, height: 300)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cv.register(FavoritesCVCell.self, forCellWithReuseIdentifier: "FavoritesCVCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    // MARK: - Internal Properties
    var favorites = [BestSeller]() {
        didSet {
            favoritesCV.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureCVContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavoritesData()
    }
    
    // MARK: - Private Methods
    private func loadFavoritesData() {
        do {
            favorites = try BestSellerPersistenceManager.manager.getSellers()
        } catch {
            print(error)
            showFavoritesErrorAlert()
        }
    }
    
    private func showFavoritesErrorAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Could not load Favorite books.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    // MARK: - Contraint Methods
    private func addSubViews() {
        self.view.addSubview(favoritesCV)
    }
    
    private func configureCVContraints() {
        favoritesCV.translatesAutoresizingMaskIntoConstraints = false
        [favoritesCV.topAnchor.constraint(equalTo: self.view.topAnchor),favoritesCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),favoritesCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),favoritesCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)].forEach({$0.isActive = true})
    }
   
}

// MARK: - Extensions
extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCV.dequeueReusableCell(withReuseIdentifier: "FavoritesCVCell", for: indexPath) as! FavoritesCVCell
        cell.backgroundColor = .clear
        
        let currentFavorite = favorites[indexPath.row]
        
        let imageURLStr = currentFavorite.bookImage
        
        ImageHelper.shared.getImage(urlStr: imageURLStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromURL):
                    cell.bookImage.image = imageFromURL
                       }
                   }
               }
        cell.weeksOnListLabel.text = "\(currentFavorite.weeksOnList) weeks on Best Seller list"
        cell.descriptionTextView.text = "\(currentFavorite.bookDescription)"
        
        cell.delegate = self
        cell.optionsButton.tag = indexPath.row

        
        return cell
    }
    
    
}

extension FavoritesVC: FavoriteCellDelegate {
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an option below", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (_) in
            do {
                try BestSellerPersistenceManager.manager.delete(tag: tag)
                self.loadFavoritesData()
            } catch {
                // TODO: Add an alert?
                print(error)
            }
            
           }
        
        let seeOnAmazonAction = UIAlertAction.init(title: "See on Amazon", style: .default) { (action) in
            // TODO: - Research how to segue to amazons site
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(seeOnAmazonAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true)
    }
    
    
}
