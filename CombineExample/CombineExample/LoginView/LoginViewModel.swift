//
//  LoginViewModel.swift
//  CombineExample
//
//  Created by Vemireddy Vijayasimha Reddy on 05/04/24.
//

import Foundation

final class LoginViewModel {
    
    @Published var response: String?
    
    func login(userName: String, password: String) {
        NetworkService.shared.login(userName: userName, password: password) { [weak self] success in
            self?.response = success
        }
    }
}
