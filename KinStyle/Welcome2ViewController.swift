//
//  Welcome2ViewController.swift
//  KinStyle call ha yes I want a taco does a problem yes mom Julio Angela
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class Welcome2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Automatically switch to GetStartedViewController after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.switchToGetStartedScreen()
        }
    }
    
    private func switchToGetStartedScreen() {
        if let getStartedVC = storyboard?.instantiateViewController(withIdentifier: "GetStartedViewController") as? GetStartedViewController {
            getStartedVC.modalPresentationStyle = .fullScreen
            self.present(getStartedVC, animated: true, completion: nil)
        } else {
            print("⚠️ ERROR: Could not instantiate GetStartedViewController from storyboard.")
        }
    }
}

