//
//  SettingsVC.swift
//  NYTApp
//
//  Created by Liana Norman on 10/18/19.
//  Copyright © 2019 Liana Norman, Sunni Tang, Adam Jackson, Malcolm Turnquest. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    // MARK: - UI Objects
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configurePickerContraints()
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
        return 10
    }

    
}
