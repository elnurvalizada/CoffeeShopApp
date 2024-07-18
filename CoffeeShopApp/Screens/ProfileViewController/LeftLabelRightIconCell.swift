//
//  LeftLabelRightIconCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 27.06.24.
//

import UIKit

class LeftLabelRightIconCell : UITableViewCell {
    
    private let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    private let leftLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .profile
        return label
    }()
    
    private let rightIcon : UIImageView = {
        let img = UIImageView()
        img.tintColor = .profile
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainStack)
        contentView.backgroundColor = .mainBackground
        
        mainStack.addArrangedSubview(leftLabel)
        mainStack.addArrangedSubview(rightIcon)
        
        
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LeftLabelRightIconCell {
    struct Model {
        let text : String
        let icon : String
    }
    
    func config(item : Model) {
        leftLabel.text = item.text
        rightIcon.image = UIImage(systemName: item.icon)
    }
}
