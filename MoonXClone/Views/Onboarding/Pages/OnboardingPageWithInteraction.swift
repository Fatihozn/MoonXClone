//
//  OnboardingPageNoInteraction 2.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit
import SnapKit

protocol OnboardingDatePickerDelegate: AnyObject {
    func saveZodiacSign()
}

final class OnboardingPageWithInteraction: UIViewController {
    
    private lazy var onboardingMainView = OnboardingPageMainView(titleText: onboardingMainViewTitleText,
                                                                 descriptionText: onboardingMainViewDescriptionText,
                                                                 imageName: imageName,
                                                                 pageType: .withDatePicker)
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Enter Your Birth Date"
        return label
    }()
    
    private lazy var dateField: UITextField = {
        let field = UITextField()
        field.textColor = .white
        field.font = UIFont.systemFont(ofSize: 18)
        field.inputView = datePicker
        field.text = Date().makeDateFormatWithoutTime()
        field.backgroundColor = UIColor(hex: "#535FD880")
        field.layer.cornerRadius = 20
        field.clipsToBounds = true
        field.textAlignment = .center
        field.textColor = .gray
        field.inputAccessoryView = createToolbar()
        return field
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.backgroundColor = UIColor(hex: "#313234")
        return datePicker
    }()
    
    var onboardingMainViewTitleText: String = ""
    var onboardingMainViewDescriptionText: String = ""
    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupUI()
    }
    
    //MARK: - SetupUI
    
    private func setupUI() {
        
        onboardingMainView.backgroundColor = .red
        
        view.addSubview(onboardingMainView)
        view.addSubview(dateLabel)
        view.addSubview(dateField)
        
        onboardingMainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingMainView.snp.bottom).offset(110)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        dateField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor(hex: "#313234")
        toolbar.isTranslucent = false
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelButton.tintColor = .systemGray3
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        
        return toolbar
    }
    
    // MARK: - objc funcs
    
    @objc
    private func doneDatePicker() {
        dateField.text = datePicker.date.makeDateFormatWithoutTime()
        
        dateField.resignFirstResponder()
    }
    
    @objc
    private func cancelDatePicker() {
        
        dateField.resignFirstResponder()
    }
    
}

extension OnboardingPageWithInteraction: OnboardingDatePickerDelegate {
    func saveZodiacSign() {
        UserDefaults.standard.set(datePicker.date.zodiacSign(), forKey: "zodiacSign")
    }
    
}
