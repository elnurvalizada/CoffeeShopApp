//
//  BaseButton.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 31.05.24.
//

import UIKit


class BaseButton : UIButton {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("button", for: .application)
        backgroundColor = .button
        layer.cornerRadius = 16
        
        snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
