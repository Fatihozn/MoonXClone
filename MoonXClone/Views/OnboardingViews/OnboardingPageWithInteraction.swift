//
//  OnboardingPageNoInteraction 2.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//


//
//  OnboardingCustomPage.swift
//  MoonXClone
//
//  Created by Fatih Özen on 21.10.2024.
//

import UIKit
import SnapKit

final class OnboardingPageWithInteraction: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = titleText
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = descriptionText
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        field.text = formatter.string(from: Date())
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
    
    var titleText: String = ""
    var descriptionText: String = ""
    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(dateLabel)
        view.addSubview(dateField)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).dividedBy(2.2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.trailing.leading.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
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

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelButton.tintColor = .systemGray3
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        
        return toolbar
    }

    @objc
    private func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateField.text = formatter.string(from: datePicker.date)
        
        dateField.resignFirstResponder()
    }

    @objc
    private func cancelDatePicker() {
        
        dateField.resignFirstResponder()
    }
    
}
