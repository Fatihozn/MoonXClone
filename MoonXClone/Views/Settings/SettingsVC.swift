//
//  SettingsVC.swift
//  MoonXClone
//
//  Created by Fatih Özen on 24.10.2024.
//

import UIKit
import NeonSDK

final class SettingsVC: UIViewController {
    
    private lazy var getPremiumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: ImageNames.getPremiumImage.rawValue)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getPremiumTapped)))
        return imageView
    }()
    
    private var tableView: NeonTableView<SettingsItemModel, SettingsTableViewCell>!
    
    private var settingsItems: [SettingsItemModel] = [
        SettingsItemModel(imageName: ImageNames.settingsItemImages.privacy.rawValue, title: "Privacy Policy"),
        SettingsItemModel(imageName: ImageNames.settingsItemImages.terms.rawValue, title: "Terms of Use"),
        SettingsItemModel(imageName: ImageNames.settingsItemImages.restore.rawValue, title: "Restore Purchase"),
        SettingsItemModel(imageName: ImageNames.settingsItemImages.help.rawValue, title: "Help Us"),
        SettingsItemModel(imageName: ImageNames.settingsItemImages.rate.rawValue, title: "Rate Us")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUI()
    }   
    
    // MARK: - setup
    
    private func setupUI() {
        title = "Settings"
        let backButton = UIBarButtonItem(image: UIImage(systemName: ImageNames.tabbarButtonImages.back.rawValue),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        
        setupCustomNavBar(leftBarButtonItems: [backButton])
        
        view.addSubview(getPremiumImageView)
        
        getPremiumImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalToSuperview().dividedBy(5.5)
        }
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView = NeonTableView<SettingsItemModel, SettingsTableViewCell>(objects: settingsItems, heightForRows: 70)
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(getPremiumImageView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.didSelect = { object, indexPath in
            if object.title == "Restore Purchase" {
                self.restorePurchase()
            }
        }
    }
    
    // MARK: - objc func
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func getPremiumTapped() {
        let vc = PaywallVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
