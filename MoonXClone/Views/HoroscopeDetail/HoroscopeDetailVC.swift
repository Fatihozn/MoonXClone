//
//  HoroscopeDetailVC.swift
//  MoonXClone
//
//  Created by Fatih Özen on 25.10.2024.
//

import UIKit
import NeonSDK

class HoroscopeDetailVC: UIViewController {
    
    private lazy var horoscopeDailyLabelView: HoroscopeDailyLabelView = {
        let view = HoroscopeDailyLabelView()
        view.backgroundColor = UIColor(hex: "#FCFCFC1A")
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var lunarTipsLabel: UILabel = {
        let label = UILabel()
        label.font = Font.custom(size: 16, fontWeight: .Medium)
        label.text = "Lunar Tips"
        label.textColor = .white
        return label
    }()
    
    private let datePicker = UIDatePicker()
    private var collectionView: NeonCollectionView<HoroscopeLunarItemModel, HoroscopeLunarCollectionViewCell>!
    
    private let lunarList = [
        HoroscopeLunarItemModel(imageName: ImageNames.lunarItemImages.business.rawValue,
                                title: "Business", responseText: "for business", color: UIColor(hex: "#8E53D8")!),
        HoroscopeLunarItemModel(imageName: ImageNames.lunarItemImages.food.rawValue,
                                title: "Food", responseText: "for food", color: UIColor(hex: "#F07A22")!),
        HoroscopeLunarItemModel(imageName: ImageNames.lunarItemImages.reletions.rawValue,
                                title: "Relations", responseText: "for relations", color: UIColor(hex: "#535FD8")!)
    ]
    
    private var selectedItem: HoroscopeLunarItemModel? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureCollectionView()
        setupUI()
        addBarButtonsToNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAIResponse(date: Date())
    }
    
    // MARK: - setupUI
    
    private func setupUI() {
        view.addBackgroundImage()
        view.addSubview(horoscopeDailyLabelView)
        view.addSubview(collectionView)
        view.addSubview(lunarTipsLabel)
        
        horoscopeDailyLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        lunarTipsLabel.snp.makeConstraints { make in
            make.top.equalTo(horoscopeDailyLabelView.snp.bottom).offset(15)
            make.leading.equalTo(horoscopeDailyLabelView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lunarTipsLabel.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
    }
    
    private func addBarButtonsToNavigationBar() {
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.tintColor = UIColor(hex: "#535FD8")
        datePicker.backgroundColor = UIColor(hex: "#3F416199")
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let datePickerItem = UIBarButtonItem(customView: datePicker)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: ImageNames.tabbarButtonImages.back.rawValue),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        
        setupCustomNavBar(leftBarButtonItems: [backButton], rightBarButtonItems: [datePickerItem])
    }
    
    // MARK: - configure
    
    private func configureCollectionView() {
        collectionView = NeonCollectionView<HoroscopeLunarItemModel, HoroscopeLunarCollectionViewCell>(
            objects: lunarList,
            leftPadding: 10,
            rightPadding: 10,
            horizontalItemSpacing: 10,
            widthForItem: 150
        )
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.didSelect = { object, indexPath in
            let item = self.lunarList[indexPath.item]
            self.selectedItem = item
            self.getAIResponse(date: self.datePicker.date, detail: item.responseText)
        }
        
    }
    
    // MARK: - API funcs
    
    private func getAIResponse(date: Date, detail: String = "") {
        getAIManagerResponse(date: date, detail: detail) { [weak self] response in
            guard let self else { return }
            DispatchQueue.main.async {
                if let item = self.selectedItem {
                    self.horoscopeDailyLabelView.title = item.title
                    self.horoscopeDailyLabelView.imageName = item.imageName
                    self.horoscopeDailyLabelView.backgroundColor = .black
                    self.horoscopeDailyLabelView.layer.borderWidth = 2
                    self.horoscopeDailyLabelView.layer.borderColor = item.color.cgColor
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    }
                }
                
                self.horoscopeDailyLabelView.text = response
            }
        }
    }
    
    // MARK: - objc func
    
    @objc
    private func dateChanged(_ sender: UIDatePicker) {
        getAIResponse(date: sender.date, detail: selectedItem?.responseText ?? "")
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}
