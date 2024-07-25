//
//  FavoriteCollectionViewCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 13.06.24.
//

import UIKit
import Kingfisher

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    let favIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "heart.fill")
        img.tintColor = .red
        return img
    }()
    
    let centerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        return sv
    }()
    
    let centerImg : UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    let centerlabel : UILabel = {
        let label = UILabel()
        label.textColor = .button
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
        contentView.backgroundColor = .subviewbackground
        contentView.addSubview(centerStack)
        contentView.addSubview(favIcon)
        
        
        centerStack.addArrangedSubview(centerImg)
        centerStack.addArrangedSubview(centerlabel)
        
        favIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
        }
        
        centerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        centerImg.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(152)
        }
    }
    
    private func setupShadow() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 8
        contentView.layer.masksToBounds = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FavoriteCollectionViewCell {
    
    func config(item : CoffeeModel) {
        centerImg.kf.setImage(with: URL(string: item.imgURL))
        centerlabel.text = item.name
    }
}
