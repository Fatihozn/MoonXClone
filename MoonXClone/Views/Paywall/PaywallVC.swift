//
//  PaywallVC.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit
import NeonSDK
import Adapty

final class PaywallVC: UIViewController {
    
    var dataClosure: (() -> Void)?
    
    private enum Products: String {
        case fiveCredits = "unlock.spark.fivecredits"
        case tenCredits = "unlock.spark.tencredit"
        case twentyCredits = "unlock.spark.twentycredit"
    }
    
    private lazy var legalView: NeonLegalView = {
        let legalView = NeonLegalView()
        legalView.configureLegalController(onVC: self, backgroundColor: .black, headerColor: .blue, titleColor: .white, textColor: .white)
        legalView.textColor = .white
        legalView.backgroundColor = .black
        
        legalView.restoreButtonClicked = {
            self.restorePurchase()
        }
        legalView.termsURL = "https://www.neonapps.co/terms-of-use"
        legalView.privacyURL = "https://www.neonapps.co/privacy-policy"
        return legalView
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hex: "#535FD8")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = Font.custom(size: 16, fontWeight: .Medium)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapPayment), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(hex: "#808080")
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    private lazy var paywallMainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Product"
        label.font = Font.custom(size: 26, fontWeight: .Bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private lazy var paywallSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Why do I need to pay?"
        label.font = Font.custom(size: 16, fontWeight: .Light)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var paywallDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Experience a virtual presence like never before, crafted just for you. Despite the computational demands, we offer this innovative solution at an affordable price."
        label.font = Font.custom(size: 13, fontWeight: .Light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var horizontalImageScrollView: HorizontalImageScrollView = {
        let images = [
            UIImage(named: "transparan")!,
            UIImage(named: "img_inapp1")!,
            UIImage(named: "img_inapp2")!,
            UIImage(named: "img_inapp3")!,
            UIImage(named: "transparan")!
        ]
        
        let imageScrollView = HorizontalImageScrollView(images: images)
        
        return imageScrollView
    }()
    
    private var tableView: NeonTableView<ProductItemModel, ProductsTableViewCell>!
    private var productItems: [ProductItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        packageFetched()
        configAdapty()
        configTableView()
        setupUI()
    }

    // MARK: - Setup
    
    private func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(paywallMainTitleLabel)
        view.addSubview(paywallSubTitleLabel)
        view.addSubview(paywallDescriptionLabel)
        view.addSubview(horizontalImageScrollView)
        view.addSubview(tableView)
        view.addSubview(legalView)
        view.addSubview(paymentButton)
        addBlur(imageName: "EllipseLeft")
        addBlur(imageName: "EllipseRight")
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        paywallMainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.4)
        }
        
        paywallSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(paywallMainTitleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        paywallDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(paywallSubTitleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.1)
        }
        
        horizontalImageScrollView.snp.makeConstraints { make in
            make.top.equalTo(paywallDescriptionLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY)
        }
        
        legalView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        paymentButton.snp.makeConstraints { make in
            make.bottom.equalTo(legalView.snp.top).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.4)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(paymentButton.snp.top).offset(-20)
        }
        
    }
    
    private func addBlur(imageName: String) {
        let blurImage = UIImageView(image: UIImage(named: imageName))
        
        blurImage.contentMode = .scaleAspectFill
        blurImage.clipsToBounds = true
        blurImage.layer.zPosition = -1
        
        view.addSubview(blurImage)
        
        if imageName == "EllipseRight" {
            blurImage.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(40)
                make.centerY.equalTo(horizontalImageScrollView)
            }
        } else {
            blurImage.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(-40)
                make.centerY.equalTo(horizontalImageScrollView)
            }
        }
    }
    
    // MARK: - config tableView
    
    private func configTableView() {
        tableView = NeonTableView<ProductItemModel, ProductsTableViewCell>(objects: productItems, heightForRows: 80)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        
        tableView.didSelect = { object, indexPath in
            
            self.paymentButton.setTitle("Purchase for \(object.price)", for: .normal)
            AdaptyManager.selectPackage(id: object.packageId)
            
            UIView.animate(withDuration: 0.3) {
                for cell in self.tableView.visibleCells as! [ProductsTableViewCell] {
                    cell.didSelect = (cell == self.tableView.cellForRow(at: indexPath) as? ProductsTableViewCell)
                }
            }
        }
        
    }
    
    // MARK: - objc funcs
    
    @objc
    private func didTapClose() {
        dataClosure?()
        dismiss(animated: true)
    }
    
    @objc
    private func didTapPayment() {
        AdaptyManager.purchase(animation: .loadingCircle2, animationColor : UIColor(hex: "#535FD8"), animationWidth: 100) {
            // Subscribed to selected package succesfully
            print("purchase succesfully")
        } completionFailure: {
            // Couldn't subscribe to selected package
            print("purchase failed")
        }
    }
    
}

// MARK: - Adapty

extension PaywallVC: AdaptyManagerDelegate {
    private func configAdapty() {
        AdaptyManager.delegate = self
        AdaptyManager.selectedPaywall = AdaptyManager.getPaywall(placementID: "placement_1")
        
        if let paywall = AdaptyManager.selectedPaywall{
            Adapty.logShowPaywall(paywall)
        }
    }
    
    func packageFetched() {
        if let fiveCreditPrice = AdaptyManager.getPackage(id: Products.fiveCredits.rawValue)?.price,
           let tenCreditPrice = AdaptyManager.getPackage(id: Products.tenCredits.rawValue)?.price,
           let twentyCreditPrice = AdaptyManager.getPackage(id: Products.twentyCredits.rawValue)?.price {
            
            productItems.append(ProductItemModel(title: "50 unique avatars", price: "\(fiveCreditPrice)", isPopular: false, packageId: Products.fiveCredits.rawValue))
            productItems.append(ProductItemModel(title: "100 unique avatars", price: "\(tenCreditPrice)", isPopular: false, packageId: Products.tenCredits.rawValue))
            productItems.append(ProductItemModel(title: "200 unique avatars", price: "\(twentyCreditPrice)", isPopular: true, packageId: Products.twentyCredits.rawValue))
            
            DispatchQueue.main.async {
                self.tableView.objects = self.productItems
            }
        }
    }
    
}
