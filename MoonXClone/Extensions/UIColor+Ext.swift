//
//  Color+Ext.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

import UIKit

extension UIColor {
    // Hex string to UIColor
    convenience init?(hex: String) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // Check if the string has a # prefix, if so remove it
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        // The string should be either 6 or 8 characters long
        guard hexFormatted.count == 6 || hexFormatted.count == 8 else {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        if hexFormatted.count == 6 {
            // No alpha value in the hex, use 1.0 as default
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else if hexFormatted.count == 8 {
            // Alpha value is provided in the hex
            let red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            let green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            let blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            let alpha = CGFloat(rgbValue & 0x000000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
}
