//
//  Loginviewcontroller.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class Loginviewcontroller: UIViewController {

    var backButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordImageView: UIImageView!  // Eye icon image view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup back button
        setupBackButton()
        
        // Set the password field to secure text entry by default (password hidden as *****)
        passwordTextField.isSecureTextEntry = true
        
        // Set the initial image for the password visibility toggle (eye icon)
        updateEyeIcon()
        
        // Add tap gesture recognizer to the image view to toggle password visibility
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
        showPasswordImageView.isUserInteractionEnabled = true  // Enable interaction with the image view
        showPasswordImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupBackButton() {
        // Create back button
        backButton = UIButton(type: .system)
        
        // Create a bold chevron icon using UIImage.SymbolConfiguration
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold) // .heavy for an even bolder icon
        let backImage = UIImage(systemName: "chevron.backward.circle", withConfiguration: boldConfig)
        
        // Set the image for the button
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .brown // Change color as per your need
        
        // Set the button frame (position and size)
        backButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40) // Adjust as needed
        
        // Add target for back button
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(backButton)
    }

    @objc func backButtonTapped() {
        // If presented modally, dismiss it
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true) // Works if using navigation
        } else {
            dismiss(animated: true, completion: nil) // Works if presented modally
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Validate the fields
        if let username = usernameTextField.text, username.isEmpty {
            showAlert(message: "Please enter your username.")
            return
        }
        
        if let password = passwordTextField.text, password.isEmpty {
            showAlert(message: "Please enter your password.")
            return
        }
        
        // If both fields are filled, show success message and switch to GenresViewController
        showSuccessMessage()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // Show success message for successful login and then switch to GenresViewController
    private func showSuccessMessage() {
        let alert = UIAlertController(title: "Success", message: "Login Successful!", preferredStyle: .alert)
        
        present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true) {
                    self.navigateToGenresScreen()
                }
            }
        })
    }

    private func navigateToGenresScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genresVC = storyboard.instantiateViewController(withIdentifier: "GenresViewController") as? GenresViewController {
            genresVC.modalPresentationStyle = .fullScreen
            self.present(genresVC, animated: true, completion: nil)
        } else {
            print("⚠️ Error: Could not load GenresViewController. Check Storyboard ID.")
        }
    }

    // Toggle the visibility of the password when the image view is tapped
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        updateEyeIcon()
    }
    
    private func updateEyeIcon() {
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        showPasswordImageView.image = UIImage(systemName: eyeImageName)
    }
}
