//
//  BucketViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 15.07.24.
//

import UIKit

class BucketViewController: UIViewController {
    
    private let emptyView : BaseShadowView = {
        let view = BaseShadowView()
        view.backgroundColor = .registerBaseBGcolor
        return view
    }()

    
    private let centerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 13
        sv.alignment = .center
        return sv
    }()
    
    private let centerLogo : UIImageView = {
        let img = UIImageView()
        img.image = UIImage.emptyIcon
        img.tintColor = .espressoBrown
        return img
    }()
    
    private let centerLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "No item in your cart"
        label.textColor = .espressoBrown
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton))
        setupUI()
        setupConstraints()
    }
    
    
    private func setupUI() {
        view.addSubview(emptyView)
        
        emptyView.addSubview(centerStack)
        
        centerStack.addArrangedSubview(centerLogo)
        centerStack.addArrangedSubview(centerLabel)
        
    }
    
    private func setupConstraints() {
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        centerStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(92)
        }
        centerLogo.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
    }

    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
}
