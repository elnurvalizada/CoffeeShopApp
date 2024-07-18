//
//  ScanPayView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 14.06.24.
//

import UIKit



class ScanPayView : UIView {
    var list : [ScanPayCollectionViewCell.Model] = [
        .init(topLeftImg: nil, topLeftText: "Rewards", topRightText: "1300", balance: "$52.17", qrCode: "asda", gradientColors: [UIColor.black.cgColor,UIColor.black.withAlphaComponent(0.65).cgColor], addFundsLabel: "Add Funds", addFundsIcon: "Dollar"),
        .init(topLeftImg: "MasterCard", topLeftText: nil, topRightText: "x1234", balance: nil, qrCode: "qwert", gradientColors: [UIColor.masterYellow.cgColor,UIColor.masterRed.cgColor],addFundsLabel: nil,addFundsIcon: nil),
        .init(topLeftImg: "VisaCard", topLeftText: nil, topRightText: "x5678", balance: nil, qrCode: "elnur", gradientColors: [UIColor.visaBlue.cgColor, UIColor.visaYellow.cgColor],addFundsLabel: nil,addFundsIcon: nil)
    ] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let defaultCardIndex = 0
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 40, height: 500)
        layout.minimumLineSpacing = 10
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ScanPayCollectionViewCell.self, forCellWithReuseIdentifier: ScanPayCollectionViewCell.identifer)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .mainBackground
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let idx = UserDefaults.standard.integer(forKey: "FirstCard")
        
        if idx != 0 {
            let defaultCard = list.remove(at: idx)
            list.insert(defaultCard, at: 0)
        }
        backgroundColor = .mainBackground
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(500)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ScanPayView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScanPayCollectionViewCell.identifer, for: indexPath) as! ScanPayCollectionViewCell
        if indexPath.row == 0  {
            cell.makeDefaultView.isHidden = true
        } else {
            cell.makeDefaultView.isHidden = false
        }
        cell.currentCellIndex = indexPath
        cell.config(item: list[indexPath.row])
        cell.delegate = self
        return cell
    }
    
   // TODO: Correct it
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}


extension ScanPayView: ScanPayCollectionViewCellDelegate {
    func didTapMakeDefault(at index: Int) {
        UserDefaults.standard.setValue(index, forKey: "FirstCard")
        let defaultCard = list.remove(at: index)
        list.insert(defaultCard, at: 0)
    }
}
