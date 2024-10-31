//
//  APIRequests.swift
//  MoonXClone
//
//  Created by Fatih Özen on 28.10.2024.
//

import Foundation

enum APIRequests {
    static func getUserContent(horoscope: String, date: Date, detail: String = "") -> String {
        "I want you to give me information about \(horoscope)' \(date) \(detail)."
    }
}
