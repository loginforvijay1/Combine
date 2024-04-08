//
//  LoginViewController.swift
//  CombineExample
//
//  Created by Vemireddy Vijayasimha Reddy on 04/04/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    
    @Published private var isTncAccepted: Bool = false
    @Published private var username: String = ""
    @Published private var password: String = ""
    
    var viewModel = LoginViewModel()
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var signupValidationPublisher: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3( $username, $password, $isTncAccepted)
            .map { username, password, isTncAccepted in
                !username.isEmpty && !password.isEmpty && isTncAccepted }
            .eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupValidationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: signupButton)
            .store(in: &subscriptions)
        
        loginServiceBinding()
    }
    
    func loginServiceBinding() {
        
        viewModel.$response.sink { completion in
            print(completion)
        } receiveValue: { response in
            if let response = response, response == "Login success" {
                self.showAlert(message: "Login successful")
            } else {
                print("login error:\(response ?? "")")
            }
        }.store(in: &subscriptions)
        
    }
    
    
    @IBAction func didChangeUserName(_ sender: UITextField) {
        username = sender.text ?? ""
    }
    
    @IBAction func didChangePassword(_ sender: UITextField) {
        password = sender.text ?? ""
    }
    
    @IBAction func didToggleTncSwitch(_ sender: UISwitch) {
        isTncAccepted = sender.isOn
    }
    
    @IBAction private func didClickOnSubmitButton(_ sender: Any) {
        viewModel.login(userName: username, password: password)
    }

    func showAlert( message: String?) {
        let alert =  UIAlertController(title: "Login User", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.moveToHome()
        }))
        self.present(alert, animated: true)
        
    }
    
    func moveToHome() {
        guard let storyBoard = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        self.navigationController?.pushViewController(storyBoard, animated: true)
    }
}
