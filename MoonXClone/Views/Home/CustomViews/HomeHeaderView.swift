//
//  HomeVC 2.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit
import NeonSDK

final class HomeHeaderView: UIView {
    
    private lazy var goodMorningLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Morning !"
        label.font = Font.custom(size: 14, fontWeight: .Bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var headerCurrentDateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().makeDateFormatWithTime()
        label.font = Font.custom(size: 12, fontWeight: .Light)
        label.textColor = .white
        return label
    }()
    
    private lazy var headerLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Istanbul, Turkey"
        label.font = Font.custom(size: 12, fontWeight: .Light)
        label.textColor = .white
        return label
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.homeHeaderMoon.rawValue)
        return imageView
    }()
    
    private lazy var headerSelectedDateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().makeDateFormatWithTime()
        label.textAlignment = .center
        label.font = Font.custom(size: 12, fontWeight: .Medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var headerWeatherStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny, 17 C"
        label.textAlignment = .center
        label.font = Font.custom(size: 12, fontWeight: .Light)
        label.textColor = .white
        return label
    }()
    
    private lazy var headerWeatherHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    var selectedDate: Date = Date() {
        didSet {
            self.headerSelectedDateLabel.text = selectedDate.makeDateFormatWithTime()
        }
    }
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpheaderWeatherHStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    
    private func setupUI() {
        addSubview(goodMorningLabel)
        addSubview(headerCurrentDateLabel)
        addSubview(headerLocationLabel)
        addSubview(headerImageView)
        addSubview(headerSelectedDateLabel)
        addSubview(headerWeatherStateLabel)
        addSubview(headerWeatherHStackView)
        
        goodMorningLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        headerCurrentDateLabel.snp.makeConstraints { make in
            make.top.equalTo(goodMorningLabel.snp.bottom).offset(5)
            make.leading.equalTo(goodMorningLabel)
            make.height.equalTo(15)
        }
        
        headerLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(headerCurrentDateLabel.snp.bottom).offset(5)
            make.leading.height.equalTo(goodMorningLabel)
        }
        
        headerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerCurrentDateLabel.snp.centerY)
        }
        
        headerSelectedDateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom).offset(20)
        }
        
        headerWeatherStateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerSelectedDateLabel.snp.bottom).offset(5)
        }
        
        headerWeatherHStackView.snp.makeConstraints { make in
            make.top.equalTo(headerWeatherStateLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    private func setUpheaderWeatherHStackView() {
        for imageName in ImageNames.weatherImages.allCases {
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName.rawValue)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            headerWeatherHStackView.addArrangedSubview(imageView)
        }
    }
    
}
