//
//  BaseInput.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 31.05.24.
//

import UIKit

class BaseInput : UIView {
    
    var haveLeftImg = false {
        didSet {
            leftImg.isHidden = !haveLeftImg
            if haveLeftImg {
                inputTextField.isSecureTextEntry = true
                leftImg.image = UIImage(systemName: "eye.slash")
                leftImg.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
                leftImg.addGestureRecognizer(tapGesture)
            } else {
                leftImg.isUserInteractionEnabled = false
            }
            leftImg.tintColor = .black
        }
    }
    
    let headingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .freshMint
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let horizontalStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    let leftImg : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let inputTextView : BaseShadowView = {
        let iv = BaseShadowView()
        iv.backgroundColor = .white
        return iv
    }()
    
    
    let inputTextField : UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headingLabel)
        addSubview(inputTextView)
        
        inputTextView.addSubview(horizontalStack)
        
        
        [
            inputTextField,
            leftImg
        ].forEach(horizontalStack.addArrangedSubview)
        
        
        
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        horizontalStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        leftImg.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(30)
        }
        
        leftImg.isHidden = haveLeftImg
        
    }
    
    @objc
    func didTapImage() {
        inputTextField.isSecureTextEntry.toggle()
        let imageName = inputTextField.isSecureTextEntry ? "eye.slash" : "eye"
        leftImg.image = UIImage(systemName: imageName)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

