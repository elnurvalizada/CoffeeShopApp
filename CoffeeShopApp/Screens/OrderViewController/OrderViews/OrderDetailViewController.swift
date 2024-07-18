//
//  OrderCoffeeDetailViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 15.07.24.
//

import UIKit
import Kingfisher

class OrderCoffeeDetailViewController : UIViewController {
    
    private let orderList : [OrderSelectView.Model] = [
        .init(header: "Cup Size", text: "Large", isStepper: false, pickerData: ["Large", "Medium", "Small"]),
        .init(header: "Add-Ins", text: "Normal Ice", isStepper: false, pickerData: ["Normal ice", "without ice"]),
        .init(header: "Sweetener", text: "Splenda® packet", isStepper: true, pickerData: nil),
        .init(header: "Flavor", text: "Pumkin Spice", isStepper: true, pickerData: nil),
        .init(header: "Creamer", text: "Oatmilk", isStepper: false, pickerData: ["Oatmilk", "Normal milk"])
    ]
    private let topView : UIView = {
        let view = UIView()
        view.backgroundColor = .freshMint
        return view
    }()
    
    private let topStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
    }()
    
    private let leftIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage.frap
        return img
    }()
    
    private let rightLabel : UILabel = {
        let label = UILabel()
        label.text = "Pumpkin Spice Latte"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let headerLabel : UILabel = {
        let label = UILabel()
        label.text = "What's included"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let mainScrollView : UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let centerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let cupOrderView : OrderSelectView = {
        let view = OrderSelectView()
        view.config(.init(header: "Cup Size", text: "Large", isStepper: false, pickerData: ["Large", "Medium", "Small"]))
        return view
    }()
    
    private let addInsOrderView : OrderSelectView = {
        let view = OrderSelectView()
        view.config(.init(header: "Add-Ins", text: "Normal Ice", isStepper: false, pickerData: ["Normal ice", "without ice"]))
        return view
    }()
    
    private let sweetenerOrderView : OrderSelectView = {
        let view = OrderSelectView()
        view.config(.init(header: "Sweetener", text: "Splenda® packet", isStepper: true, pickerData: nil))
        return view
    }()
    
    private let flavorOrderView : OrderSelectView = {
        let view = OrderSelectView()
        view.config(.init(header: "Flavor", text: "Pumkin Spice", isStepper: true, pickerData: nil))
        return view
    }()
    
    private let creamerOrderView : OrderSelectView = {
        let view = OrderSelectView()
        view.config(.init(header: "Creamer", text: "Oatmilk", isStepper: false, pickerData: ["Oatmilk", "Normal milk"]))
        return view
    }()
    
    
    private let addToCardButton : BaseButton = {
        let button = BaseButton()
        button.setTitle("Add to Cart $ 6.99", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let emptyView : UIView = {
        let ev = UIView()
        ev.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        return ev
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        setupUI()
        setupConstraints()
    }
    
    
    private func setupUI() {
        view.addSubview(topView)
        view.addSubview(headerLabel)
        view.addSubview(mainScrollView)
        
        topView.addSubview(topStack)
        
        topStack.addArrangedSubview(leftIcon)
        topStack.addArrangedSubview(rightLabel)
        
        mainScrollView.addSubview(centerStack)
        
        [
            cupOrderView,
            addInsOrderView,
            sweetenerOrderView,
            flavorOrderView,
            creamerOrderView,
            addToCardButton,
            emptyView
        ].forEach(centerStack.addArrangedSubview)
    }
    
    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        topStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(15)
        }
        leftIcon.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        centerStack.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.snp.top).offset(3)
            make.leading.trailing.equalToSuperview().inset(12)
            make.width.equalTo(mainScrollView.snp.width).offset(-24)
            make.bottom.equalToSuperview()
        }
        
        
    }
}
