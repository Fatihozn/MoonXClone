//
//  CustomCollectionViewCell.swift
//  MoonXClone
//
//  Created by Fatih Özen on 25.10.2024.
//

import NeonSDK
import UIKit

final class HoroscopeLunarCollectionViewCell: NeonCollectionViewCell<HoroscopeLunarItemModel> {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with item: HoroscopeLunarItemModel) {
        super.configure(with: item)
        titleLabel.text = item.title
        imageView.image = UIImage(named: item.imageName)
        contentView.backgroundColor = item.color
    }
  
    private func setupSubviews() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
    }
}
