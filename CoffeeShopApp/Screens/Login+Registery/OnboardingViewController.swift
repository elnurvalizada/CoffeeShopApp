//
//  OnboardingViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 31.05.24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let list : [OnboardingModel] = [
        .init(img: "first", title: "Choose and customize your drinks with simplicity", subtitle: "You want your drink and you want it your way so be bold and customize the way that makes you the happiest!"),
        .init(img: "second", title: "No time to waste when you need your coffee", subtitle: "We’ve crafted a quick and easy way for you to order your favorite coffee or treats thats fast!"),
        .init(img: "third", title: "Who doesn’t love rewards? We LOVE rewards!", subtitle: "If you’re like us you love getting freebies and rewards! That’s why we have the best reward program in the coffee game!")
    ]
    
    private var scrollPos = 0
    
    private let leftBottomImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "firstCount")
        return iv
    }()
    
    private let buttonStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.spacing = 130
        return sv
    }()
    
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 120, height: 480)
        let collectionvView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionvView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        
        collectionvView.showsHorizontalScrollIndicator = false
        collectionvView.isScrollEnabled = false
        return collectionvView
    }()
    
    private let nextbutton : BaseButton = {
        let button = BaseButton()
        button.setTitle("Go on", for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = .espressoBrown
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .registerBaseBGcolor
        collectionView.backgroundColor = .registerBaseBGcolor
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupUI()
        collectionView.dataSource = self
        
        nextbutton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }
    
    func setupUI() {
        
        view.addSubview(collectionView)
        view.addSubview(buttonStack)
        
        
        
        buttonStack.addArrangedSubview(leftBottomImageView)
        buttonStack.addArrangedSubview(nextbutton)
        
        
        collectionView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(500)
        }
        
        
        buttonStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        leftBottomImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        
    }
    
    @objc
    func nextPage() {
        scrollPos += 1
        if scrollPos > 2 {
            let tabbarVC = TabBarController()
            tabbarVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(tabbarVC, animated: false)
            return
            
        }
        let indexPath = IndexPath(row: scrollPos, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        

        switch scrollPos {
        case 0:
            leftBottomImageView.image = UIImage(named: "firstCount")
        case 1:
            leftBottomImageView.image = UIImage(named: "secondCount")
        case 2:
            leftBottomImageView.image = UIImage(named: "thirdCount")
        default:
            return
        }
    }
}



extension OnboardingViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.config(item: list[indexPath.row])
        return cell
    }

}
