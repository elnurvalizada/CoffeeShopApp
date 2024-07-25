//
//  HomeViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 02.06.24.
//
import UIKit

class HomeViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private let welcomeView: WelcomeView = {
        let wv = WelcomeView()
        wv.backgroundColor = .mainBackground
        return wv
    }()

    private let bonusView: BonusView = {
        let bv = BonusView()
        return bv
    }()

    private let favoriteView: FavoriteView = {
        let fv = FavoriteView()
        fv.headerLabel.text = "Your favorites"
        return fv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(welcomeView)
        scrollView.addSubview(bonusView)
        scrollView.addSubview(favoriteView)

        bonusView.layer.cornerRadius = 16
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        welcomeView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(40)
            make.leading.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }

        bonusView.snp.makeConstraints { make in
            make.top.equalTo(welcomeView.snp.bottom).offset(18)
            make.leading.trailing.equalTo(scrollView).inset(25)
            make.width.equalTo(scrollView.snp.width).inset(25)
        }

        favoriteView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(18)
            make.leading.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }
    }
}
