//
//  SignupViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class SignupViewController: UIViewController {

    var backButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordImageView: UIImageView!  // Eye icon image view

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Setup UI elements
        setupBackButton()
        
        // Set the password field to secure text entry by default
        passwordTextField.isSecureTextEntry = true
        
        // Set the initial image for the password visibility toggle (eye icon)
        updateEyeIcon()
        
        // Add tap gesture recognizer to the image view to toggle password visibility
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
        showPasswordImageView.isUserInteractionEnabled = true  // Enable interaction with the image view
        showPasswordImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupBackButton() {
        backButton = UIButton(type: .system)
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold) // Use `.heavy` for an even bolder look
        let backImage = UIImage(systemName: "chevron.backward.circle", withConfiguration: boldConfig)
        
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .brown
        backButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40) // Adjust position as needed
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        view.addSubview(backButton) // Add to the view
    }

    @objc func backButtonTapped() {
        print("🔹 Back button tapped!") // Debugging

        if let navController = navigationController {
            print("🔹 Using Navigation Controller - Popping ViewController")
            navController.popViewController(animated: true)
        } else {
            print("🔹 Using Modal Presentation - Dismissing ViewController")
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        var missingFields = [String]() // Array to store names of missing fields
        
        // Check if each field is empty and add to missingFields array
        if let firstName = firstNameTextField.text, firstName.isEmpty {
            missingFields.append("First Name")
        }
        
        if let lastName = lastNameTextField.text, lastName.isEmpty {
            missingFields.append("Last Name")
        }
        
        if let email = emailTextField.text, email.isEmpty {
            missingFields.append("Email")
        }
        
        if let password = passwordTextField.text, password.isEmpty {
            missingFields.append("Password")
        }
        
        // If there are missing fields, show an alert with all the missing fields
        if !missingFields.isEmpty {
            let missingFieldsString = missingFields.joined(separator: ", ")
            let alertMessage = "Please enter the following: \(missingFieldsString)"
            showAlert(message: alertMessage)
        } else {
            // Show signup success message
            showSuccessAlert()
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Sign up successful!", preferredStyle: .alert)
        
        // Present the alert
        present(alert, animated: true, completion: {
            // After a short delay, dismiss the alert and navigate to the next screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.dismiss(animated: true) {
                    // Perform the navigation after alert dismissal
                    self.navigateToGenresScreen()
                }
            }
        })
    }

    private func navigateToGenresScreen() {
        print("🔹 Navigating to GenresViewController...")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Check if GenresViewController is loaded properly from the storyboard
        if let genresVC = storyboard.instantiateViewController(withIdentifier: "GenresViewController") as? GenresViewController {
            print("🔹 GenresViewController found, presenting...")
            genresVC.modalPresentationStyle = .fullScreen
            self.present(genresVC, animated: true, completion: nil)
        } else {
            print("⚠️ Error: Could not load GenresViewController. Check Storyboard ID.")
        }
    }

    // Toggle the visibility of the password when the image view is tapped
    @objc func togglePasswordVisibility() {
        // Toggle the secure text entry (this hides/shows the password)
        passwordTextField.isSecureTextEntry.toggle()
        
        // Update the eye icon based on the visibility
        updateEyeIcon()
    }
    
    // Helper function to update the eye icon image
    private func updateEyeIcon() {
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        showPasswordImageView.image = UIImage(systemName: eyeImageName)
    }
}
