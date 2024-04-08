//
//  HomeViewController.swift
//  CombineExample
//
//  Created by Vemireddy Vijayasimha Reddy on 05/04/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLbl: UILabel!
    
    private let viewModel = HomeViewModel()
    
    var subScriber = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinders()
        viewModel.getLoggedInUser()
    }
    
    private func setupBinders() {
        
        viewModel.$welcomeMessage.sink { [weak self] message in
            self?.welcomeLbl.text = message
        }.store(in: &subScriber)
        
    }
}
