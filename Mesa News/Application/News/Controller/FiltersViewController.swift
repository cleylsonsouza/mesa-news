//
//  FiltersViewController.swift
//  Mesa News
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var titleTextField: CustomOutlinedTextField!
    @IBOutlet weak var publishedAtTextField: CustomOutlinedTextField!
    @IBOutlet weak var favoritesSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
    }

    @IBAction func didTapClearButton(_ sender: Any) {
        clearAllFilters()
    }
}

extension FiltersViewController: FiltersProtocol {
    
    func clearAllFilters() {
        
    }
    
    func configureViewComponents() {
        let backButton = UIBarButtonItem()
        backButton.title = "feed"
        backButton.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        titleTextField.placeholder = "By title"
        titleTextField.keyboardType = .emailAddress
        titleTextField.clearButtonMode = .never
        
        publishedAtTextField.placeholder = "Published at"
        publishedAtTextField.clearButtonMode = .never
        publishedAtTextField.backgroundColor = Colors.background1
    }
}
