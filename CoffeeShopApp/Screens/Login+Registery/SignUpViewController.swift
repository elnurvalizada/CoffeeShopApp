//
//  SignUpViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 31.05.24.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

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
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .espressoBrown
        return label
    }()
    
    let subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "We are so excited you’re ready to become apart of our coffee network! don’t forget  check out your perks!"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .espressoBrown
        label.numberOfLines = 0
        return label
    }()
    
    let usernameInputField : BaseInput = {
        let usernameInput = BaseInput()
        usernameInput.inputTextField.placeholder = "Enter username"
        usernameInput.headingLabel.text = "Username"
        return usernameInput
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
    
    let registerButton : BaseButton = {
        let button = BaseButton()
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.white, for: .application)
        return button
    }()
    
    
    let haveAccountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Already have an account?"
        label.textAlignment = .center
        return label
    }()
    
    let signInButton : BaseButton = {
        let button = BaseButton()
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(.white, for: .application)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .registerBaseBGcolor
        setupUI()
        setupConstraints()
        
        
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisteryButton), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(iconImgView)
        view.addSubview(actionSheetView)
        
        actionSheetView.addSubview(containerStack)
        
        
        [
            titleLabel,
            subtitleLabel,
            usernameInputField,
            emailInputField,
            passwordInputField,
            registerButton,
            haveAccountLabel,
            signInButton
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
    private func didTapSignInButton() {
        let nextVc = LoginViewController()
        nextVc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nextVc, animated: false)
        
    }
    
    @objc
    private func didTapRegisteryButton() {
        guard let username = usernameInputField.inputTextField.text, !username.isEmpty else {
            showAlert(title: "Validation failed", message: "Name can not be empty")
            return
        }
        
        guard let email = emailInputField.inputTextField.text, !email.isEmpty else {
            showAlert(title: "Validation failed", message: "Email can not be empty")
            return
        }
        guard let password = passwordInputField.inputTextField.text, !password.isEmpty else {
            showAlert(title: "Validation failed", message: "Password can not be empty")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] signInResult, signInError in
            if let error = signInError {
                self?.showAlert(title: "Something went wrong", message: error.localizedDescription)
                return
            }
            print("User sign up already")
            let nextVc = OnboardingViewController()
            self?.navigationController?.pushViewController(nextVc, animated: false)
            let newUserInfo = Auth.auth().currentUser
            print(newUserInfo?.email)
            print(newUserInfo?.uid)
            
            if let userId = newUserInfo?.uid {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["username": username, "userId": userId])
            }
        }
        
    }

}

