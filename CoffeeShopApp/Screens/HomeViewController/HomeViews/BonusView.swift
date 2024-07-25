//
//  BonusView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 12.06.24.
//
import UIKit
import SnapKit

class BonusView : BaseShadowView {

    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .freshMint
        return view
    }()

    private let topViewStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()

    private let desStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()

    private let rightStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 30
        return sv
    }()

    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.text = "BONUS REWARDS"
        label.textColor = .white
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Coffee Delivered to your house"
        label.textColor = .white
        return label
    }()

    private let desHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Order 2 bags of coffee and get bonus stars!"
        label.numberOfLines = 0
        label.textColor = .button
        return label
    }()

    private let desBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Order any of our coffee and get an additional 30 Stars! Now that’s how you get free coffee!"
        label.textColor = .button
        label.numberOfLines = 0
        return label
    }()

    private let rightImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "CoffeeImgBonus")
        return img
    }()

    private let shopNowButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Shop now", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .subviewbackground
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(topView)
        addSubview(rightStack)
        addSubview(desStack)
        
        topView.addSubview(topViewStack)
        
        topViewStack.addArrangedSubview(bonusLabel)
        topViewStack.addArrangedSubview(titleLabel)
        
        rightStack.addArrangedSubview(rightImg)
        rightStack.addArrangedSubview(shopNowButton)
        
        desStack.addArrangedSubview(desHeaderLabel)
        desStack.addArrangedSubview(desBodyLabel)
        
        topView.layer.cornerRadius = 8
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        topViewStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        desStack.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(32)
            make.trailing.equalTo(rightStack.snp.leading)
        }
        
        rightStack.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(10)
        }
        
        rightImg.snp.makeConstraints { make in
            make.height.equalTo(116)
            make.width.equalTo(96)
        }
        
        shopNowButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
}
