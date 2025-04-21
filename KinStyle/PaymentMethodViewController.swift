//
//  PaymentMethodViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on  2/16/25.
//

// PaymentMethodViewController.swift
import UIKit

class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var contactInfoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Payment Method"
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc func saveButtonTapped() {
        // Check if any of the fields are empty
        if contactInfoTextField.text?.isEmpty == true ||
           nameTextField.text?.isEmpty == true ||
           addressTextField.text?.isEmpty == true ||
           countryTextField.text?.isEmpty == true {
            
            // Display an alert if any field is empty
            showAlert(message: "Please fill in all the details.")
        } else {
            // Save the payment details to UserDefaults
            UserDefaults.standard.set(contactInfoTextField.text, forKey: "contactInfo")
            UserDefaults.standard.set(nameTextField.text, forKey: "name")
            UserDefaults.standard.set(addressTextField.text, forKey: "address")
            UserDefaults.standard.set(countryTextField.text, forKey: "country")

            // Instantiate PlaceOrderViewController and navigate
            if let placeOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "CardInfoViewController") as? CardInfoViewController {
                // Push PlaceOrderViewController to show the order details
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(placeOrderVC, animated: true)
                } else {
                    self.present(placeOrderVC, animated: true, completion: nil)
                }
            } else {
                print("Error: CardInfoViewController not found in storyboard.")
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
