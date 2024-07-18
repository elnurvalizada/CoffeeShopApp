//
//  LoginViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 31.05.24.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {

    let iconImgView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Icon")
        return img
    }()
    
    
    let actionSheetView : BaseShadowView = {
        let av = BaseShadowView()
        av.layer.cornerRadius = 36
        av.backgroundColor = .sheetBGcolor
        return av
    }()
    
    
    let containerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Sign Ip"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .espressoBrown
        return label
    }()
    
    let subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "It’s coffee time! Login and lets get all the coffee in the world! Or at least iced coffee."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .espressoBrown
        label.numberOfLines = 0
        return label
    }()
    let emailInputField : BaseInput = {
        let emailInput = BaseInput()
        emailInput.inputTextField.placeholder = "Type your email"
        emailInput.headingLabel.text = "Email"
        return emailInput
    }()
    
    let passwordInputField : BaseInput = {
        let passwordInput = BaseInput()
        passwordInput.inputTextField.placeholder = "Type your password"
        passwordInput.headingLabel.text = "Password"
        passwordInput.haveLeftImg = true
        return passwordInput
    }()
    
    let loginButton : BaseButton = {
        let button = BaseButton()
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .application)
        return button
    }()
    
    
    let haveAccountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Don’t have an account?"
        label.textAlignment = .center
        return label
    }()
    
    let registeryButton : BaseButton = {
        let button = BaseButton()
        button.setTitle("CREATE NEW ACCOUNT", for: .normal)
        button.setTitleColor(.white, for: .application)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .registerBaseBGcolor
        setupUI()
        setupConstraints()
        
        registeryButton.addTarget(self, action: #selector(didTapRegisteryButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(iconImgView)
        view.addSubview(actionSheetView)
        
        actionSheetView.addSubview(containerStack)
        
        
        [
            titleLabel,
            subtitleLabel,
            emailInputField,
            passwordInputField,
            loginButton,
            haveAccountLabel,
            registeryButton
        ].forEach(containerStack.addArrangedSubview)
        
        containerStack.setCustomSpacing(16, after: titleLabel)
    }
    
    
    private func setupConstraints() {
        iconImgView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(57)
            make.height.equalTo(90)
        }
        
        actionSheetView.snp.makeConstraints { make in
            make.top.equalTo(iconImgView.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(actionSheetView.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(46)
        }
    }
    
    
    @objc
    private func didTapRegisteryButton() {
        self.dismiss(animated: false)
    }

    @objc
    private func didTapLoginButton() {
        guard let email = emailInputField.inputTextField.text, !email.isEmpty else { return }
        guard let password = passwordInputField.inputTextField.text, !password.isEmpty else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                switch AuthErrorCode.Code(rawValue: error.code) {
                case .operationNotAllowed:
                    self.showAlert(title: "Validation Failed", message: error.localizedDescription)
                case .userDisabled:
                    self.showAlert(title: "Validation Failed", message: error.localizedDescription)
                case .wrongPassword:
                    self.showAlert(title: "Validation Failed", message: error.localizedDescription)
                case .invalidEmail:
                    self.showAlert(title: "Validation Failed", message: error.localizedDescription)
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                print("User signs in successfully")
                let userInfo = Auth.auth().currentUser
                print(userInfo)
            }
        }
    }
    
}

