//
//  PassCodeViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 17.07.24.
//

import UIKit

class PassCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private let centerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    private let centerLabel : UILabel = {
        let label = UILabel()
        label.text = "Enter your pincode"
        label.textAlignment = .center
        return label
    }()
    private func setupUI() {
        
        let passcode = Passcode()
        passcode.frame = CGRect(x: 100, y: 100, width: 300, height: 44)
        passcode.becomeFirstResponder()
        passcode.didFinishedEnterCode = {code in
            print("code is:\(code)")
        }
        
        view.addSubview(centerStack)
        centerStack.addArrangedSubview(centerLabel)
        centerStack.addArrangedSubview(passcode)
        
        centerStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.leading.trailing.equalToSuperview().inset(36)
        }
    }
}
