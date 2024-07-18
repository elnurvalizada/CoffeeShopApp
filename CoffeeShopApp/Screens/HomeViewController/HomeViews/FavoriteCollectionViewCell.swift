//
//  FavoriteCollectionViewCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 13.06.24.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    
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
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
        contentView.backgroundColor = .white
        contentView.addSubview(centerStack)
        
        
        centerStack.addArrangedSubview(centerImg)
        centerStack.addArrangedSubview(centerlabel)
        
        
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
    struct Model {
        let img : String
        let label : String
        let isFavorite : Bool
    }
    
    func config(item : Model) {
        centerImg.image = UIImage(named: item.img)
        centerlabel.text = item.label
    }
}
