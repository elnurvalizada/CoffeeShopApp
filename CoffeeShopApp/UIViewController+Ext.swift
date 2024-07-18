//
//  UIViewController+Ext.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 15.07.24.
//

import UIKit


extension UIViewController {
    func showAlert(title : String, message : String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Close", style: .cancel))
        present(alertVC, animated: true)
        
    }
}
