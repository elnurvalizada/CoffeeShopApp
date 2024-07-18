//
//  RewardView.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 20.06.24.
//

import UIKit

class RewardView : UIView {
    
    
    private let centerStack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 15
        return sv
    }()
    
    private let rewardLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .medium)
        label.text = "1300"
        return label
    }()
    
    private let qrcodeImg : UIImageView = {
        let img = UIImageView()
        return img
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(centerStack)
        
        centerStack.addArrangedSubview(rewardLabel)
        centerStack.addArrangedSubview(qrcodeImg)
        
        centerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        qrcodeImg.image = generateQRCode(from: "Aaaaa")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                colorFilter?.setValue(CIColor(color: .black), forKey: "inputColor0") // QR code color
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
}
