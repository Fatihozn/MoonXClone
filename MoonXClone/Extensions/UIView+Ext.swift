//
//  UIView+Ext.swift
//  MoonXClone
//
//  Created by Fatih Özen on 24.10.2024.
//

import UIKit
import SnapKit

extension UIView {
    
    func addBackgroundImage() {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: ImageNames.homeHeaderBackgroundImage.rawValue)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.zPosition = -1
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height / 2.3)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
        self.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.height).dividedBy(2.3)
        }
        
    }
    
}
