//
//  ScanPayCollectionViewCell.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 14.06.24.
//

import UIKit


protocol ScanPayCollectionViewCellDelegate: AnyObject {
    func didTapMakeDefault(at index: Int)
}

class ScanPayCollectionViewCell: UICollectionViewCell {
    weak var delegate: ScanPayCollectionViewCellDelegate?
    var currentCellIndex : IndexPath? = nil
    
    private let topStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 60
        sv.alignment = .center
        return sv
    }()
    
    private let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 10
        return sv
    }()
    
    private let leftLabel : UILabel = {
        let label = UILabel()
        label.text = "Rewards"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let leftImg : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private let rightLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    
    private let balanceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private var qrCodeImg : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    
    
    private let bottomStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.spacing = 20
        return sv
    }()
    
    
    let addFundsView : UIView = {
        let lv = UIView()
        return lv
    }()
    
    private let bottomRightView : UIView = {
        let rv = UIView()
        return rv
    }()
    
    let makeDefaultView : UIView = {
        let rv = UIView()
        return rv
    }()
    
    private let makeDefaultLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "Make Default"
        label.textColor = .white
        return label
    }()
    
    private let makeDefaultIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "checkmark.circle")
        img.tintColor = .white
        return img
    }()
    
    private let addFundsLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "Add Funds"
        label.textColor = .white
        return label
    }()
    
    private let addFundsIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "dollarsign.circle")
        img.tintColor = .white
        return img
    }()
    
    private let bottomRightLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "Manage"
        label.textColor = .white
        return label
    }()
    
    private let bottomRightIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "gear")
        img.tintColor = .white
        return img
    }()
    
    private var gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        setupUI()
        setupConstraints()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeDefaultTapped))
            makeDefaultView.addGestureRecognizer(tapGesture)
            makeDefaultView.isUserInteractionEnabled = true
    }
    
    @objc 
    private func makeDefaultTapped() {
        print("Pressed")
        if let idx = currentCellIndex {
            delegate?.didTapMakeDefault(at: idx.row)
            
        }
    }
    private func setupUI() {
        contentView.addSubview(topStack)
        contentView.addSubview(mainStack)
        
        [
            leftLabel,
            leftImg,
            rightLabel
        ].forEach(topStack.addArrangedSubview)
        
        [
            balanceLabel,
            qrCodeImg,
            bottomStack
        ].forEach(mainStack.addArrangedSubview)
        
        
        mainStack.setCustomSpacing(48, after: qrCodeImg)
        
        [
            addFundsView,
            makeDefaultView,
            bottomRightView
        ].forEach(bottomStack.addArrangedSubview)
        
        addFundsView.addSubview(addFundsIcon)
        addFundsView.addSubview(addFundsLabel)
        
        bottomRightView.addSubview(bottomRightIcon)
        bottomRightView.addSubview(bottomRightLabel)
        
        makeDefaultView.addSubview(makeDefaultIcon)
        makeDefaultView.addSubview(makeDefaultLabel)
    }
    
    private func setupConstraints() {
        topStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(50)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        addFundsIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalTo(addFundsView.snp.centerX)
        }
        addFundsLabel.snp.makeConstraints { make in
            make.top.equalTo(addFundsIcon.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        makeDefaultIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalTo(makeDefaultView.snp.centerX)
        }
        makeDefaultLabel.snp.makeConstraints { make in
            make.top.equalTo(makeDefaultIcon.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomRightIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalTo(bottomRightView.snp.centerX)
        }
        bottomRightLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomRightIcon.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        qrCodeImg.snp.makeConstraints { make in
            make.size.equalTo(175)
        }
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            // Apply color filter
            if let outputImage = filter.outputImage {
                let colorFilter = CIFilter(name: "CIFalseColor")
                colorFilter?.setDefaults()
                colorFilter?.setValue(outputImage, forKey: "inputImage")
                colorFilter?.setValue(CIColor(color: .white), forKey: "inputColor0") // QR code color
                colorFilter?.setValue(CIColor(color: .clear), forKey: "inputColor1") // Background color
                
                if let coloredOutput = colorFilter?.outputImage {
                    let transform = CGAffineTransform(scaleX: 10, y: 10)
                    let scaledImage = coloredOutput.transformed(by: transform)
                    return UIImage(ciImage: scaledImage)
                }
            }
        }
        return nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension ScanPayCollectionViewCell {
    struct Model {
        let topLeftImg : String?
        let topLeftText : String?
        let topRightText : String
        let balance : String?
        let qrCode : String // it will be corrected
        let gradientColors : [CGColor]
        let addFundsLabel : String?
        let addFundsIcon : String?
    }
    
    func config(item: Model) {
        if let topLeftImg = item.topLeftImg {
            leftImg.image = UIImage(named: topLeftImg)
            leftImg.isHidden = false
            leftImg.snp.remakeConstraints { make in
                make.width.equalTo(120)
                make.height.equalTo(60)
            }
            leftLabel.isHidden = true
        } else {
            leftImg.isHidden = true
        }

        if let topLeftText = item.topLeftText {
            leftLabel.text = topLeftText
            leftLabel.isHidden = false
            leftImg.isHidden = true
        } else {
            leftLabel.isHidden = true
        }

        rightLabel.text = item.topRightText

        if let balance = item.balance {
            balanceLabel.text = balance
        } else {
            balanceLabel.text = ""
        }

        addFundsView.isHidden = item.addFundsLabel == nil

        qrCodeImg.image = generateQRCode(from: item.qrCode)

        // Remove previous gradient layer if any
        contentView.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        // Update gradient
        gradient.frame = contentView.bounds
        gradient.colors = item.gradientColors
        gradient.startPoint = .init(x: 0, y: 0)
        gradient.endPoint = .init(x: 1, y: 1)
        gradient.cornerRadius = 15
        contentView.layer.insertSublayer(gradient, at: 0)
        contentView.layer.cornerRadius = 15
    }
}
