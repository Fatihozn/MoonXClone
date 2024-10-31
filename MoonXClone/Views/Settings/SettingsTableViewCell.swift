//
//  ViewController.swift
//  MoonXClone
//
//  Created by Fatih Özen on 24.10.2024.
//

import UIKit
import NeonSDK

class SettingsTableViewCell: NeonTableViewCell<SettingsItemModel> {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#535FD836")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var iconImageView = UIImageView()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.centerY.equalTo(iconImageView)
        }
    }
    
    override func configure(with settingsItem: SettingsItemModel) {
        super.configure(with: settingsItem)
        titleLabel.text = settingsItem.title
        iconImageView.image = UIImage(named: settingsItem.imageName)
    }
}
