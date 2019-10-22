//
//  BestSellersVC.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class BestSellersVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var bestSellerCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame:.zero , collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 250)
        cv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cv.register(BestSellerCVCell.self, forCellWithReuseIdentifier: "BestSellerCVCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    // MARK: - Internal Properties
    var bestSellers = [BestSeller]() {
        didSet {
            bestSellerCV.reloadData()
        }
    }
    
    var categories = [Category]() {
        didSet {
            categoryPicker.reloadAllComponents()
            loadBestSellerData()
        }
    }
    
    var currentCategory: String = "combined-print-and-e-book-fiction"

    var googleBook: VolumeInfo!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubViews()
        configureBestSellerCV()
        configurePickerConstriants()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCategoriesData()
    }
    
    // MARK: - Private functions
    
    private func loadCategoriesData() {
        let urlStr = CategoriesAPIClient.getSearchResultsURLStr()
        
        CategoriesAPIClient.manager.getCategories(urlStr: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    //TODO: Add Alert, cannot load data
                    print("CategoriesAPIClient: \(error)")
                case .success(let data):
                    self.categories = data
                }
            }
        }
    }
    
    private func loadBestSellerData() {
        let urlStr = BestSellersAPIClient.getSearchResultsURLStr(from: currentCategory)
    
        BestSellersAPIClient.manager.getBestSellers(urlStr: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    //TODO: Add Alert, cannot load data
                    print("BestSellerAPIClient: \(error)")
                case .success(let data):
                    self.bestSellers = data
                }
            }
        }
    }
    
    // MARK: - Contraint Methods
    private func addSubViews() {
        self.view.addSubview(bestSellerCV)
        self.view.addSubview(categoryPicker)
    }
    
    
    private func configureBestSellerCV() {
        bestSellerCV.translatesAutoresizingMaskIntoConstraints = false
        [bestSellerCV.topAnchor.constraint(equalTo: self.view.topAnchor), bestSellerCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),bestSellerCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), bestSellerCV.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)].forEach({$0.isActive = true})
        
    }
    
    private func configurePickerConstriants() {
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        
        [categoryPicker.topAnchor.constraint(equalTo: bestSellerCV.bottomAnchor), categoryPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), categoryPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), categoryPicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)].forEach({$0.isActive = true})
    }
    

}

// MARK: - Extensions
extension BestSellersVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    
}

extension BestSellersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestSellers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bestSellerCV.dequeueReusableCell(withReuseIdentifier: "BestSellerCVCell", for: indexPath) as! BestSellerCVCell
        let currentBestSeller = bestSellers[indexPath.row]
        
        
        cell.backgroundColor = .white
        cell.weeksOnListLabel.text = "\(currentBestSeller.weeksOnList) weeks on Best Seller list"
        cell.descriptionTextView.text = "\(currentBestSeller.bookDescription)"
        
        let imageURLStr = currentBestSeller.bookImage
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
      
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = BestDVC()
        detailVC.selectedBestSeller = bestSellers[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

