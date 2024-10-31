//
//  OnboardingCustomPage.swift
//  MoonXClone
//
//  Created by Fatih Özen on 21.10.2024.
//

import UIKit
import SnapKit

final class OnboardingPageNoInteraction: UIViewController {
    
    private lazy var onboardingMainView = OnboardingPageMainView(titleText: onboardingMainViewTitleText,
                                                                 descriptionText: onboardingMainViewDescriptionText,
                                                                 imageName: imageName,
                                                                 pageType: .noDatePicker)
    
    var onboardingMainViewTitleText: String = ""
    var onboardingMainViewDescriptionText: String = ""
    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(onboardingMainView)
        
        onboardingMainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
