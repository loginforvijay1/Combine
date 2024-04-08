//
//  HomeViewModel.swift
//  CombineExample
//
//  Created by Vemireddy Vijayasimha Reddy on 05/04/24.
//

import Foundation
import Combine

final class HomeViewModel {
    
   @Published var welcomeMessage: String?
    
    func getLoggedInUser() {
        let user = NetworkService.shared.getLoggedInUser()
        self.welcomeMessage = "Hello, \(user?.firstName ?? "") \(user?.lastName ?? "")"
    }
    
}
