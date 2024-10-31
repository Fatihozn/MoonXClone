//
//  ProductsTableViewCell.swift
//  MoonXClone
//
//  Created by Fatih Özen on 29.10.2024.
//


import UIKit
import NeonSDK

final class ProductsTableViewCell: NeonTableViewCell<ProductItemModel> {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#121212")
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(hex: "#535FD8")?.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.paywallImages.checkboxunselected.rawValue)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "100 unique avatars"
        label.font = Font.custom(size: 16, fontWeight: .Light)
        label.textColor = .white
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$9.99"
        label.font = Font.custom(size: 16, fontWeight: .Medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var popularityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popularProduct")
        imageView.isHidden = true
        return imageView
    }()
    
    var didSelect: Bool = false {
        didSet {
            if didSelect {
                iconImageView.image = UIImage(named: ImageNames.paywallImages.checkboxselected.rawValue)
                containerView.backgroundColor = UIColor(hex: "#181D38")
                containerView.layer.borderWidth = 2
            } else {
                iconImageView.image = UIImage(named: ImageNames.paywallImages.checkboxunselected.rawValue)
                containerView.backgroundColor = UIColor(hex: "#121212")
                containerView.layer.borderWidth = 0
            }
        }
    }
   
    
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
        containerView.addSubview(priceLabel)
        contentView.addSubview(popularityImageView)
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        
        popularityImageView.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.top)
            make.trailing.equalTo(containerView.snp.trailing).offset(-15)
        }
    }
    
    override func configure(with product: ProductItemModel) {
        super.configure(with: product)
        titleLabel.text = product.title
        priceLabel.text = product.price
        popularityImageView.isHidden = !product.isPopular
    }
}
