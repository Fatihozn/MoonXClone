//
//  OnboardingPageMainView.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit
import SnapKit

final class OnboardingPageMainView: UIView {
    
    enum OnboardingPageType {
        case withDatePicker
        case noDatePicker
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = titleText
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = descriptionText
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
    private let titleText: String
    private let descriptionText: String
    private let imageName: String
    private let pageType: OnboardingPageType
    
    init(titleText: String, descriptionText: String, imageName: String, pageType: OnboardingPageType) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.imageName = imageName
        self.pageType = pageType
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        if pageType == .noDatePicker {
            imageView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(40)
                make.centerX.equalToSuperview()
                make.trailing.equalToSuperview().offset(-10)
                make.leading.equalToSuperview().offset(10)
            }
            
        } else {
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(10)
                make.centerX.equalToSuperview()
                make.trailing.equalToSuperview().offset(-10)
                make.leading.equalToSuperview().offset(10)
            }
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.trailing.leading.equalTo(titleLabel)
        }
        
    }
    
}
