//
//  CustomWhatIsForTodayButton.swift
//  MoonXClone
//
//  Created by Fatih Özen on 23.10.2024.
//

import UIKit
import NeonSDK

final class CustomWhatIsForTodayButton: UIButton {
    
    private lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(horoscopeImageView)
        view.addSubview(horoscopeTitleLabel)
        view.addSubview(horoscopeDescriptionLabel)
        return view
    }()
    
    var horoscopeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.fish.rawValue)
        return imageView
    }()
    
    var horoscopeTitleLabel: UILabel = {
        let label = UILabel()
        
        if let zodiacSign = UserDefaults.standard.string(forKey: "zodiacSign") {
            label.text = zodiacSign
        }
        
        label.font = Font.custom(size: 18, fontWeight: .Bold)
        label.textColor = .white
        return label
    }()
    
    var horoscopeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Daily Horoscope"
        label.font = Font.custom(size: 16, fontWeight: .Medium)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        subView.isUserInteractionEnabled = false
        addSubview(subView)
        
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horoscopeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
            make.leading.equalToSuperview().offset(40)
        }
        
        horoscopeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horoscopeImageView.snp.top).offset(5)
            make.leading.equalTo(horoscopeImageView.snp.trailing).offset(20)
        }
        
        horoscopeDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(horoscopeImageView.snp.bottom).offset(-5)
            make.leading.equalTo(horoscopeTitleLabel)
        }
    }
    
}
