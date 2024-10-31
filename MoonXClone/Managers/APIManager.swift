//
//  APIManager.swift
//  MoonXClone
//
//  Created by Fatih Özen on 25.10.2024.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func makeOpenAIRequest(content: String, completion: @escaping (String?) -> ()) {
        let apiKey = " "
        let apiUrl = "https://api.openai.com/v1/chat/completions"
        
        let url = URL(string: apiUrl)!
        
        let json: [String: Any] = [
            "model": "gpt-4o",
            "messages": [
                [
                    "role": "system",
                    "content": "You are a horoscope interpreter and you need to provide specific daily information based on the horoscope and date information given to you. When providing this information, you need to write it as a single paragraph."
                ],
                [
                    "role": "user",
                    "content": content
                ]
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Failed to serialize JSON.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
                    
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
            
        }
        
        task.resume()
    }
    
}
