//
//  OrderSelectView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 15.07.24.
//

import UIKit
class OrderSelectView: UIView {
    
    private var pickerData: [String]?
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let mainView: BaseShadowView = {
        let mv = BaseShadowView()
        mv.backgroundColor = .white
        mv.layer.cornerRadius = 5
        return mv
    }()
    
    private let centerStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 5
        return sv
    }()
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        label.layer.borderWidth = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(20)
        }
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        return label
    }()
    
    private let rightIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right.circle.fill")
        img.tintColor = .black
        return img
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 7
        stepper.stepValue = 1
        stepper.value = 0
        return stepper
    }()
    
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var mainViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 60)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        addSubview(mainView)
        
        mainView.addSubview(centerStack)
        
        centerStack.addArrangedSubview(leftLabel)
        centerStack.addArrangedSubview(countLabel)
        centerStack.addArrangedSubview(UIView())
        centerStack.addArrangedSubview(picker)
        centerStack.addArrangedSubview(rightIcon)
        centerStack.addArrangedSubview(stepper)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            mainViewHeightConstraint.isActive = true
            mainViewHeightConstraint.constant = 60
        }
        
        centerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        rightIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        stepper.isHidden = true
        rightIcon.isHidden = true
        
        
        
        stepper.addTarget(self, action: #selector(didChangeStepperValue), for: .touchUpInside)
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    @objc private func handlePickerTap() {
        mainViewHeightConstraint.constant = 100
        picker.isHidden = false
        leftLabel.isHidden = true
        countLabel.isHidden = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.rightIcon.image = UIImage(systemName: "chevron.down.circle.fill")
        }
    }
    
    @objc private func didChangeStepperValue() {
        countLabel.text = "\(Int(stepper.value))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OrderSelectView {
    struct Model {
        let header : String
        let text : String
        let isStepper : Bool
        let pickerData : [String]?
    }
    
    
    func config(_ model : Model) {
        headerLabel.text = model.header
        leftLabel.text = model.text
        picker.isHidden = true
        if model.isStepper {
            stepper.isHidden = false
            rightIcon.isHidden = true
            countLabel.isHidden = false
            
        } else {
            stepper.isHidden = true
            rightIcon.isHidden = false
            countLabel.isHidden = true
            
            let tapgetureForPicker = UITapGestureRecognizer(target: self, action: #selector(handlePickerTap))
            mainView.addGestureRecognizer(tapgetureForPicker)
            
            pickerData = model.pickerData
        }
    }
}


extension OrderSelectView : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UIView.animate(withDuration: 0.6) {
            self.leftLabel.text = self.pickerData?[row]
            self.picker.isHidden = true
            self.leftLabel.isHidden = false
            
            self.mainViewHeightConstraint.constant = 60
            self.rightIcon.image = UIImage(systemName: "chevron.right.circle.fill")
        }
        
    }
    
    
}
