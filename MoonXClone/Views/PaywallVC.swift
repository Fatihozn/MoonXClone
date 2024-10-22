//
//  PaywallVC.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit
import NeonSDK

final class PaywallVC: UIViewController {

    private lazy var paymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Ödeme yap", for: .normal)
        button.titleLabel?.font = Font.custom(size: 18, fontWeight: .Bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapPayment), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        view.addSubview(paymentButton)
        
        paymentButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
        }
        
    }
    
    @objc func didTapPayment() {
        
        let homeVC = HomeVC()
        
        homeVC.modalPresentationStyle = .fullScreen
        
        present(homeVC, animated: false, completion: nil)
    }
    
}
