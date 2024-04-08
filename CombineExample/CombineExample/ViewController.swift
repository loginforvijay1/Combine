//
//  ViewController.swift
//  CombineExample
//
//  Created by Vemireddy Vijayasimha Reddy on 02/04/24.
//

import UIKit
import Combine

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        publisherCall()
    }
        
    func publisherCall() {
        
        let justPublisher = Just(addTwoNumbers(a: 1, b: 4))
        
        let subscriber = Subscribers.Sink<Int, Never > { completion in
            debugPrint(completion)
        } receiveValue: { value in
            print("response: \(value)")
        }
        
        justPublisher.subscribe(subscriber)
    }
    
    func addTwoNumbers(a: Int, b: Int) -> Int {
        a + b
    }

}

