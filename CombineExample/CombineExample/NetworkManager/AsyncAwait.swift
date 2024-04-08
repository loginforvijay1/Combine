//
//  AsyncAwait.swift
//  CombineExample
//
//  Created by Vemireddy Vijayasimha Reddy on 04/04/24.
//

import Foundation

struct UserModel : Codable {
    let userName: String
    let profile: String
    let info: String
}
class NetworkManagerNew {
    
    func getUserData() async throws -> UserModel? {
        
        let endPoint = ""
        
        guard let url = URL(string: endPoint) else { return nil}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(UserModel.self, from: data)
            
        } catch {
            throw error
        }
    }
}
