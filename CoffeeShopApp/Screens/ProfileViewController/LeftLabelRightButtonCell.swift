//
//  LeftLabelRightButtonCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 27.06.24.
//

import UIKit


class LeftLabelRightButtonCell : UITableViewCell {
    var delegate : (() -> ())?
    private let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    
    private let leftLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .profile
        label.text = "cwdwecx"
        return label
    }()
    
    private let rightButton : UISwitch = {
        let button = UISwitch()
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainStack)
        contentView.backgroundColor = .mainBackground
        
        mainStack.addArrangedSubview(leftLabel)
        mainStack.addArrangedSubview(rightButton)
        
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        rightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(title : String) {
        leftLabel.text = title
    }
    
    @objc
    private func didTapRightButton() {
        delegate?()
    }
}
