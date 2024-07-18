//
//  OnboardingCollectionViewCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 31.05.24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    private let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 80
        return sv
    }()
    
    private let centerImgView : UIImageView = {
        let img = UIImageView()
        return img
        
    }()
   
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    
    private func setupUI() {
        contentView.addSubview(mainStack)
        
        [
            centerImgView,
            titleLabel,
            subtitleLabel
        ].forEach(mainStack.addArrangedSubview)
        
        mainStack.setCustomSpacing(4, after: titleLabel)
        
        
        
        
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        centerImgView.snp.makeConstraints { make in
            make.height.equalTo(245)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(item : OnboardingModel) {
        centerImgView.image = UIImage(named: item.img)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
