//
//  HomeVC.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit
import NeonSDK
import SnapKit

final class HomeVC: NeonViewController {
    
    private var homeHeaderView = HomeHeaderView()
    
    private lazy var whatIsForTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "What is for Today?"
        label.font = Font.custom(size: 16, fontWeight: .Medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var whatIsForTodayButton: CustomWhatIsForTodayButton = {
        let button = CustomWhatIsForTodayButton()
        button.backgroundColor = UIColor(hex: "#535FD8B2")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(whatIsForTodayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var horoscopeDailyLabelView: HoroscopeDailyLabelView = {
        let view = HoroscopeDailyLabelView()
        view.backgroundColor = UIColor(hex: "#FCFCFC1A")
        view.layer.cornerRadius = 10
        view.text = "Response Loading..."
        view.layer.masksToBounds = true
        return view
    }()
    
    private let datePicker = UIDatePicker()
    private var getData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        presentPaywallVC()
        setupUI()
        addBarButtonsToNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if getData {
            self.getAIResponse(date: Date())
            getData = false
        }
    }

    // MARK: - setupUI
    
    private func setupUI() {
        view.addBackgroundImage()
        mainStack.addSpacer(view.frame.height / 8)
        mainStack.addArrangedSubview(homeHeaderView)
        mainStack.addArrangedSubview(whatIsForTodayLabel)
        mainStack.addArrangedSubview(whatIsForTodayButton)
        mainStack.addArrangedSubview(horoscopeDailyLabelView)
        
        homeHeaderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        
        whatIsForTodayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(homeHeaderView.snp.bottom)
        }
        
        whatIsForTodayButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalToSuperview().offset(-20)
            make.top.equalTo(whatIsForTodayLabel.snp.bottom).offset(5)
            make.height.equalTo(110)
        }
        
        horoscopeDailyLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(whatIsForTodayButton.snp.bottom).offset(20)
        }
        
        mainStack.addSpacer(20)
        
    }
    
    private func addBarButtonsToNavigationBar() {
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.tintColor = UIColor(hex: "#535FD8")
        datePicker.backgroundColor = UIColor(hex: "#3F416199")
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let datePickerItem = UIBarButtonItem(customView: datePicker)
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: ImageNames.tabbarButtonImages.settings.rawValue),
                                             style: .plain,
                                             target: self,
                                             action: #selector(settingsButtonTapped))
        
        setupCustomNavBar(leftBarButtonItems: [settingsButton], rightBarButtonItems: [datePickerItem])
    }
    
    // MARK: - paywall
    
    private func presentPaywallVC() {
        if Neon.isUserPremium == false {
            let vc = PaywallVC()
            vc.dataClosure = { 
                self.getAIResponse(date: Date())
            }
            vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.present(vc, animated: true)
            }
        } else {
            getData = true
        }
    }
    
    // MARK: - API Funcs
    
    private func getAIResponse(date: Date) {
        getAIManagerResponse(date: date) { [weak self] response in
            guard let self else { return }
            DispatchQueue.main.async {
                self.horoscopeDailyLabelView.text = response
            }
        }
    }
    
    // MARK: - objc func
    
    @objc
    private func dateChanged(_ sender: UIDatePicker) {
        homeHeaderView.selectedDate = sender.date
        getAIResponse(date: sender.date)
    }
    
    @objc
    private func whatIsForTodayButtonTapped() {
        navigationController?.pushViewController(HoroscopeDetailVC(), animated: true)
    }
    
    @objc
    private func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
}
