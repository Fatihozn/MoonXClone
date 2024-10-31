//
//  UIViewController+Ext.swift
//  MoonXClone
//
//  Created by Fatih Özen on 24.10.2024.
//

import UIKit
import NeonSDK

extension UIViewController {
    
    func setupCustomNavBar(leftBarButtonItems: [UIBarButtonItem]? = [], rightBarButtonItems: [UIBarButtonItem]? = []) {
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = .white
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            appearance.backgroundColor = .clear
            navigationBar.scrollEdgeAppearance = appearance
            
            appearance.backgroundColor = UIColor(hex: "#3F4161")?.withAlphaComponent(0.7)
            navigationBar.standardAppearance = appearance
        }
        
        if let leftBarButtonItems {
            navigationItem.leftBarButtonItems = leftBarButtonItems
        }
        
        if let rightBarButtonItems {
            navigationItem.rightBarButtonItems = rightBarButtonItems
        }
    }
    
    // MARK: - API funcs
    
    func getAIManagerResponse(date: Date, detail: String = "", completion: @escaping (String) -> ()) {
        LottieManager.showFullScreenLottie(animation: .loadingLines2, color: UIColor(hex: "#535FD8"), backgroundOpacity: 0.9)
        
        if let zodiacSign = UserDefaults.standard.string(forKey: "zodiacSign") {
            APIManager.shared.makeOpenAIRequest(content: APIRequests.getUserContent(horoscope: zodiacSign, date: date, detail: detail)) { response in
                guard let response else { return }
                
                completion(response)
                DispatchQueue.main.async {
                    LottieManager.removeFullScreenLottie()
                }
            }
        }
    }
    
    // MARK: - Adapty funcs
    
    func restorePurchase() {
        AdaptyManager.restorePurchases(vc: self, animation: .loadingCircle2, showAlerts: false) {
            // Subscription restored succesfully
            print("restore purchase succesfully")
        } completionFailure: {
            // Couldn't subscribe to selected package
            print("restore purchase failed")
        }
    }
    
}
