//
//  String+Ext.swift
//  MoonXClone
//
//  Created by Fatih Özen on 23.10.2024.
//

import UIKit

extension Date {
    func makeDateFormatWithTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH.mm"
        
        return formatter.string(from: self)
    }
    
    func makeDateFormatWithoutTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: self)
    }
    
    func zodiacSign() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month], from: self)
        
        guard let day = components.day, let month = components.month else {
            return "Invalid date"
        }
        
        switch (month, day) {
        case (1, 20...31), (2, 1...18):
            return "Aquarius"
        case (2, 19...29), (3, 1...20):
            return "Pisces"
        case (3, 21...31), (4, 1...19):
            return "Aries"
        case (4, 20...30), (5, 1...20):
            return "Taurus"
        case (5, 21...31), (6, 1...20):
            return "Gemini"
        case (6, 21...30), (7, 1...22):
            return "Cancer"
        case (7, 23...31), (8, 1...22):
            return "Leo"
        case (8, 23...31), (9, 1...22):
            return "Virgo"
        case (9, 23...30), (10, 1...22):
            return "Libra"
        case (10, 23...31), (11, 1...21):
            return "Scorpio"
        case (11, 22...30), (12, 1...21):
            return "Sagittarius"
        case (12, 22...31), (1, 1...19):
            return "Capricorn"
        default:
            return "Invalid date"
        }
    }

}
