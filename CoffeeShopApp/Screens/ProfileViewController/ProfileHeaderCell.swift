//
//  ProfileHeaderCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 27.06.24.
//

import UIKit


class ProfileHeaderCell : UITableViewCell {
    
    
    private let mainView : WelcomeView = {
        let mv = WelcomeView()
        return mv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        contentView.backgroundColor = .mainBackground
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.nameLabel.text = "Account"
        mainView.coffeeLabel.text = "Welcome Vasken!"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
