//
//  SettingsVC.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    var categories = [Category]() {
        didSet {
            categoryPicker.reloadAllComponents()
        }
    }
    
    // MARK: - UI Objects
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    // MARK: Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configurePickerContraints()
    }
    
    func loadData() {
        let url = CategoriesAPIClient.getSearchResultsURLStr()
        CategoriesAPIClient.manager.getCategories(urlStr: url, completionHandler: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let category):
                    self.categories = category
                    print(self.categories.count)
                case .failure(let error):
                    print(error)
                }
            }
            
        })
    }
    
    //MARK: Constraint Methods
    private func addSubviews() {
        view.addSubview(categoryPicker)
    }
    
    private func configurePickerContraints() {
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        
        [categoryPicker.topAnchor.constraint(equalTo: self.view.topAnchor), categoryPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), categoryPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), categoryPicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)].forEach({$0.isActive = true})
    }
}

// MARK: Extensions
extension SettingsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categories[row].listName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = categories[row].listNameEncoded
        print(category)
        UserDefaultsWrapper.manager.storeFavCats(favCat: category)
        let alertController = UIAlertController(title: "Category Saved!", message: "", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed OK");
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        print(UserDefaultsWrapper.manager.getFavCats()!)
        
    }
    
    
    
    
}
