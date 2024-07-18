//
//  WelcomeView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 12.06.24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WelcomeView : UIView {
    
    private let nameStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    
    private let nameProfileStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    
    
    var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Good Morning Vasken!"
        return label
    }()
    
    var coffeeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Yay for Coffeeeee! ☕️"
        
        return label
    }()
    
    private let rightImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ProfileImg")
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let user = Auth.auth().currentUser
        
        
        addSubview(nameProfileStack)
        
        
        nameProfileStack.addArrangedSubview(nameStack)
        nameProfileStack.addArrangedSubview(rightImg)
        
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(coffeeLabel)
        
        
        nameProfileStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        rightImg.snp.makeConstraints { make in
            make.size.equalTo(62)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
