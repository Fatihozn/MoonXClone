//
//  HoroscopeResponseLabelView.swift
//  MoonXClone
//
//  Created by Fatih Özen on 25.10.2024.
//

import UIKit
import NeonSDK

class HoroscopeDailyLabelView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.custom(size: 18, fontWeight: .Medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var horoscopeDailyLabel: UILabel = {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0 // Sınırsız satır
        label.textAlignment = .left // Soldan hizalama
        label.lineBreakMode = .byWordWrapping // Kelimeye göre satır kırma
        label.font = Font.custom(size: 14, fontWeight: .Medium)
        label.textColor = .white
        return label
    }()
    
    var text: String = "" {
        didSet {
            horoscopeDailyLabel.text = text
        }
    }
    
    var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
            setuphoroscopeResponseLabel()
        }
    }
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    init() {
        super.init(frame: .zero)
        setuphoroscopeResponseLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuphoroscopeResponseLabel() {
        if !subviews.isEmpty {
            self.subviews.forEach { $0.removeFromSuperview() }
        }
        
        self.addSubview(horoscopeDailyLabel)
        
        if imageName != "" {
            
            self.addSubview(imageView)
            self.addSubview(titleLabel)
            
            imageView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.centerY.equalTo(imageView)
                make.leading.equalTo(imageView.snp.trailing).offset(12)
            }
            
            horoscopeDailyLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(14)
                make.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
            }
            
        } else {
            horoscopeDailyLabel.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
    }
    
}
