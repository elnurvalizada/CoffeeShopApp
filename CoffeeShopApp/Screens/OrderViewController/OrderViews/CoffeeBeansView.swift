//
//  CoffeeBeansView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 16.07.24.
//
//

import UIKit


class CoffeeBeansView : UIView {
    
    var onDrinkSelected: ((CoffeeBeansModel) -> Void)?
    
    var list : [CoffeeBeansModel] = [ ]
    
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
        collectionView.register(CoffeeBeansCell.self, forCellWithReuseIdentifier: CoffeeBeansCell.identifer)
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NetworkManager().fetchProducts { model in
            self.list = model
            print("---------------",model)
            self.collectionView.reloadData()
            
        }
        
        setupView()
        setupContraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        seeAllButton.addTarget(self, action: #selector(didTapSeeAllButton), for: .touchUpInside)
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


extension CoffeeBeansView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeBeansCell.identifer, for: indexPath) as! CoffeeBeansCell
        cell.config(item: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDrinkSelected?(list[indexPath.row])
    }
}
