//
//  CustomNavigationController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 12.06.24.
//
import UIKit

class CustomNavigationController: UINavigationController {

    private let leftMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "line.horizontal.3")
        return button
    }()
    
    private let centerLogo: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage.icon
        logoView.contentMode = .scaleAspectFill
        return logoView
    }()
    
    private let rightBucketButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "handbag")
        return button
    }()
    
    private let bucketcountView : UIView = {
        let view = UIView()
        view.backgroundColor = .freshMint
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let bucketcountLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        setupNavigationItems(for: topViewController)
       
        rightBucketButton.target = self
        rightBucketButton.action = #selector(didTapRightButton)
    }
    
    
    private func setupNavigationBarAppearance() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        
        
        navigationBar.tintColor = .black
        navigationBar.backgroundColor = .mainBackground
        navigationBar.standardAppearance = standard
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationBar.layer.shadowOpacity = 0.1
        navigationBar.layer.shadowRadius = 8
        navigationBar.layer.masksToBounds = false
        navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        
        centerLogo.snp.makeConstraints { make in
            make.height.equalTo(47)
            make.width.equalTo(30)
        }
        
    }
    
    @objc private func didTapRightButton() {
        let nextVC = BucketViewController()
        nextVC.modalPresentationStyle = .popover
        self.present(nextVC, animated: true)
    }
    
    private func setupNavigationItems(for viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        viewController.navigationItem.leftBarButtonItem = leftMenuButton
        viewController.navigationItem.titleView = centerLogo
        viewController.navigationItem.rightBarButtonItem = rightBucketButton
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        setupNavigationItems(for: viewControllers.last)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        setupNavigationItems(for: viewController)
    }
    
    
}
