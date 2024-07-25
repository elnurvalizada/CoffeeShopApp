//
//  OrderCoffeeDetailViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 15.07.24.
//

import UIKit
import Kingfisher
import Firebase

class OrderCoffeeDetailViewController : UIViewController {
    var id : String = ""
    var isFavorite : Bool = false
    var imgURL : String = ""
    var price : Double = 0
    
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
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.button
        button.imageView?.snp.makeConstraints({ make in
            make.height.equalTo(25)
            make.width.equalTo(15)
        })
        return button
    }()
    
    private let makeFavoriteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor.button
        button.imageView?.snp.makeConstraints({ make in
            make.size.equalTo(26)
        })
        return button
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
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        makeFavoriteButton.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
    }
    
    
    private func setupUI() {
        view.addSubview(topView)
        view.addSubview(headerLabel)
        view.addSubview(mainScrollView)
        
        topView.addSubview(topStack)
        topView.addSubview(backButton)
        topView.addSubview(makeFavoriteButton)
        
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
        
        if isFavorite {
            makeFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            makeFavoriteButton.tintColor = .red
        }
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
        
        backButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }
        
        makeFavoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
        }
        
        leftIcon.snp.makeConstraints { make in
            make.height.equalTo(400)
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
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapFavButton() {
        isFavorite.toggle()
        makeFavoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
        makeFavoriteButton.tintColor = isFavorite ? .red : .button
        if isFavorite {
            Firestore.firestore().collection("FavoriteCoffee").document(id).setData(["id" : id, "name" : rightLabel.text ?? "", "imgURL" : imgURL, "price" : price])
            Firestore.firestore().collection("Coffee").document(id).updateData(["isFavorite" : true])
        } else {
            Firestore.firestore().collection("FavoriteCoffee").document(id).delete()
            Firestore.firestore().collection("Coffee").document(id).updateData(["isFavorite" : false])
        }
    }
}


extension OrderCoffeeDetailViewController {
    func config(item : CoffeeModel) {
        id = item.id
        isFavorite = item.isFavorite
        imgURL = item.imgURL
        let url = URL(string: item.imgURL)
        leftIcon.kf.setImage(with: url)
        rightLabel.text = item.name
        price = item.price
        addToCardButton.setTitle("Add to Cart $ \(price)", for: .normal)
    }
}
