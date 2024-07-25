//
//  DrinksView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 13.06.24.
//

import UIKit


class DrinksView : UIView {
    
    var onDrinkSelected: ((CoffeeModel) -> Void)?
    
    var coffeeList : [CoffeeModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let viewStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        return sv
    }()
    
    let headerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        
        return sv
    }()
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let seeAllButton : UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.freshMint, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return button
    }()
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        layout.itemSize = .init(width: width / 2 - 55, height: 200)
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DrinksCollectionViewCell.self, forCellWithReuseIdentifier: DrinksCollectionViewCell.identifer)
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupContraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        seeAllButton.addTarget(self, action: #selector(didTapSeeAllButton), for: .touchUpInside)
        
        CoffeeManager.shared.fetchAllCoffees { list in
            self.coffeeList = list
        }
    }
    
    private func setupView() {
        addSubview(viewStack)
        
        viewStack.addArrangedSubview(headerStack)
        viewStack.addArrangedSubview(collectionView)
        
        headerStack.addArrangedSubview(headerLabel)
        headerStack.addArrangedSubview(seeAllButton)
    }
    
    private func setupContraints() {
        
        viewStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(430)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapSeeAllButton() {
        
    }
}


extension DrinksView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coffeeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinksCollectionViewCell.identifer, for: indexPath) as! DrinksCollectionViewCell
        cell.config(item: coffeeList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDrinkSelected?(coffeeList[indexPath.row])
    }
}
