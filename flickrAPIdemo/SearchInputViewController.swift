//
//  SearchInputViewController.swift
//  flickrAPIdemo
//
//  Created by Stan Liu on 2020/2/25.
//  Copyright © 2020 Stan Liu. All rights reserved.
//

import UIKit

class SearchInputViewController: UIViewController {
    
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var perPageInputField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "搜尋輸入頁"
        self.searchBtn.isEnabled = false

        textInputField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        perPageInputField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        textInputField.delegate = self
        perPageInputField.delegate = self
    }
    
    @IBAction func onSearchClicked(_ sender: Any) {
        guard let searchText = textInputField.text,
            let perPage = perPageInputField.text else {return}
        if searchText.count > 0 && perPage.count > 0 {
            let searchOutputVC = SearchOutputViewController()
            searchOutputVC.titleText = searchText
            searchOutputVC.perPage = perPage
            self.navigationController?.pushViewController(searchOutputVC, animated: true)
        }
    }
    
    @objc func textFieldDidChanged() {
        guard let searchText = textInputField.text,
            let perpage = perPageInputField.text else {return}
        if searchText.count > 0 && perpage.count > 0 {
            searchBtn.isEnabled = true
        } else {
            searchBtn.isEnabled = false
        }
    }
}

extension SearchInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
