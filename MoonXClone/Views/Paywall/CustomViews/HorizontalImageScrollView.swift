//
//  HorizontalImageScrollView.swift
//  MoonXClone
//
//  Created by Fatih Özen on 29.10.2024.
//

import UIKit
import SnapKit

class HorizontalImageScrollView: UIView {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var imageViews: [UIImageView] = []
    
    init(images: [UIImage]) {
        super.init(frame: .zero)
        setupView()
        configureImages(images: images)
        scrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - setup
    
    private func setupView() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.decelerationRate = .fast
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.height.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
    
    // MARK: - config
    
    private func configureImages(images: [UIImage]) {
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.alpha = 0.7
            
            if imageView.image == UIImage(named: "transparan") {
                imageView.snp.makeConstraints { make in
                    make.width.equalTo(90)
                    make.height.equalTo(180)
                }
            } else {
                imageView.snp.makeConstraints { make in
                    make.width.height.equalTo(180)
                }
            }
            
            if image == images[1] {
                scrollAnimation(imageView: imageView, x: 1, y: 0.75)
            } else {
                scrollAnimation(imageView: imageView, x: -1, y: 0.75)
            }
            
            stackView.addArrangedSubview(imageView)
            imageViews.append(imageView)
        }
    }
    
}


// MARK: - scrollView funcs

extension HorizontalImageScrollView: UIScrollViewDelegate  {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width / 2
        
        for imageView in imageViews {
            let offset = abs(centerX - imageView.center.x)
           
            scrollAnimation(imageView: imageView, x: 1 - offset / 500, y: 0.75)
        }
    }
    
    private func scrollAnimation(imageView: UIImageView ,x: CGFloat, y: CGFloat) {
        let scale = max(x, y)
        imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        let alpha = max(x, y)
        imageView.alpha = alpha
    }
    
}
