//
//  GetStartedViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        navigateToScreen(identifier: "LoginViewController")
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        navigateToScreen(identifier: "SignupViewController")
    }
    
    private func navigateToScreen(identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Make sure this matches your storyboard's name
        if let nextVC = storyboard.instantiateViewController(withIdentifier: identifier) as? UIViewController {
            // Check if we have a navigationController, if yes, push; otherwise, present modally
            if let navController = navigationController {
                navController.pushViewController(nextVC, animated: true)
            } else {
                nextVC.modalPresentationStyle = .fullScreen
                present(nextVC, animated: true, completion: nil)
            }
        } else {
            print("⚠️ Error: Could not find the view controller with identifier \(identifier).")
        }
    }
}

