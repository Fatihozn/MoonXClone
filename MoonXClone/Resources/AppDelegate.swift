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
//        Neon.activatePremiumTest()
        
        Font.configureFonts(font: .Inter)
        Neon.configure(
                   window: &window,
                   onboardingVC: OnboardingVC(),
                   paywallVC: UINavigationController(rootViewController: HomeVC()),
                   homeVC: UINavigationController(rootViewController: HomeVC())
               )
        
        AdaptyManager.configure(withAPIKey: "public_live_SymXXvAI.exhKLTMR4geVdTZVPJK4", placementIDs: ["placement_1"])
        
        return true
    }

}

