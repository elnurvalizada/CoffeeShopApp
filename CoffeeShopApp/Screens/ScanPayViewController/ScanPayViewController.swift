//
//  ScanPayViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 14.06.24.
//
import UIKit
import SnapKit

class ScanPayViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let topStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let topLeftView: UIView = {
        let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        return lv
    }()
    
    let topRightView: UIView = {
        let rv = UIView()
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Scan & Pay"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Rewards Only"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftSeperatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .freshMint
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let rightSeperatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .freshMint.withAlphaComponent(0.1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let scanPayView: ScanPayView = {
        let spv = ScanPayView()
        spv.translatesAutoresizingMaskIntoConstraints = false
        return spv
    }()
    
    let rewardView: RewardView = {
        let rv = RewardView()
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardView.isHidden = true
        
        view.backgroundColor = .mainBackground
        setupUI()
        setupConstraints()
        
        let leftViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftViewMode))
        topLeftView.addGestureRecognizer(leftViewTapGesture)
        let rightViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightViewMode))
        topRightView.addGestureRecognizer(rightViewTapGesture)
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(topStack)
        scrollView.addSubview(scanPayView)
        scrollView.addSubview(rewardView)
        
        topStack.addArrangedSubview(topLeftView)
        topStack.addArrangedSubview(topRightView)
        
        topLeftView.addSubview(leftLabel)
        topLeftView.addSubview(leftSeperatorLine)
        
        topRightView.addSubview(rightLabel)
        topRightView.addSubview(rightSeperatorLine)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(24)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        leftSeperatorLine.snp.makeConstraints { make in
            make.top.equalTo(leftLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        rightSeperatorLine.snp.makeConstraints { make in
            make.top.equalTo(rightLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        scanPayView.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(55)
            make.leading.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        rewardView.snp.makeConstraints { make in
            make.top.equalTo(scanPayView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }
    }
    
    @objc
    func leftViewMode() {
        leftSeperatorLine.backgroundColor = .freshMint
        rightSeperatorLine.backgroundColor = .freshMint.withAlphaComponent(0.1)
        rewardView.isHidden = true
        scanPayView.isHidden = false
    }
    
    @objc
    func rightViewMode() {
        rightSeperatorLine.backgroundColor = .freshMint
        leftSeperatorLine.backgroundColor = .freshMint.withAlphaComponent(0.1)
        rewardView.isHidden = false
        scanPayView.isHidden = true
    }
}
