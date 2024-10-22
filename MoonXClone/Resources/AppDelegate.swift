//
//  AppDelegate.swift
//  MoonXClone
//
//  Created by Fatih Özen on 21.10.2024.
//

import UIKit
import NeonSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Font.configureFonts(font: .Inter)
        Neon.configure(
                   window: &window,
                   onboardingVC: OnboardingVC(),
                   paywallVC: PaywallVC(),
                   homeVC: UINavigationController(rootViewController: HomeVC())
               )
        
        return true
    }

}

