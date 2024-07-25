//
//  FavoriteView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 13.06.24.
//

import UIKit


class FavoriteView : UIView {
    
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
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        layout.itemSize = .init(width: width / 2 - 55, height: 200)
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifer)
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupContraints()
        
        collectionView.dataSource = self
        CoffeeManager.shared.fetchFavCoffees { list in
            self.coffeeList = list
        }
        listenToCoffeeUpdates()
    }
    
    private func setupView() {
        addSubview(viewStack)
        
        viewStack.addArrangedSubview(headerLabel)
        viewStack.addArrangedSubview(collectionView)
    }
    
    private func setupContraints() {
        
        viewStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(230)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func listenToCoffeeUpdates() {
        CoffeeManager.shared.listenToCoffeeUpdates { list in
            self.coffeeList = list
        }
    }
}


extension FavoriteView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coffeeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifer, for: indexPath) as! FavoriteCollectionViewCell
        cell.config(item: coffeeList[indexPath.row])
        return cell
    }
}
