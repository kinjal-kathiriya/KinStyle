//
//  PlaceOrderViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on  2/16/25.
//

import UIKit

class PlaceOrderViewController: UIViewController {

    // Labels for contact info
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    // Labels for the cart item details
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    // Text field for total price
    @IBOutlet weak var totalPriceTextField: UITextField!

    // Variables to hold passed data
    var contactInfo: String?
    var name: String?
    var address: String?
    var country: String?
    var totalPrice: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default text for contact info labels
        contactInfoLabel.text = contactInfo ?? "No contact info available"
        nameLabel.text = name ?? "No name available"
        addressLabel.text = address ?? "No address available"
        countryLabel.text = country ?? "No country available"

        // Retrieve cart item details from UserDefaults
        if let itemName = UserDefaults.standard.string(forKey: "cartItemName"),
           let imageString = UserDefaults.standard.string(forKey: "cartItemImage"),
           let imageData = Data(base64Encoded: imageString),
           let itemImage = UIImage(data: imageData) {
            
            // Set item details on the UI
            itemNameLabel.text = itemName
            itemImageView.image = itemImage
            
            // Handle price specifically
            if let itemPriceString = UserDefaults.standard.string(forKey: "cartItemPrice") {
                // Debug print the retrieved price
                print("Retrieved raw price string: \(itemPriceString)")
                
                // Try to convert the price string to Double
                if let itemPrice = Double(itemPriceString) {
                    totalPrice = itemPrice
                    
                    // Format the price for display
                    itemPriceLabel.text = "$\(itemPriceString)"
                    totalPriceTextField.text = "$\(totalPrice)"
                    totalPriceTextField.isUserInteractionEnabled = false  // Make it read-only
                    
                    print("Successfully converted price: \(totalPrice)")
                } else {
                    print("Failed to convert price string: \(itemPriceString)")
                    
                    // Try one more time with additional cleaning
                    let cleanedString = itemPriceString.trimmingCharacters(in: .whitespacesAndNewlines)
                                                      .replacingOccurrences(of: "$", with: "")
                                                      .replacingOccurrences(of: ",", with: "")
                    
                    if let cleanedPrice = Double(cleanedString) {
                        totalPrice = cleanedPrice
                        itemPriceLabel.text = "$\(cleanedPrice)"
                        totalPriceTextField.text = "$\(totalPrice)"
                        totalPriceTextField.isUserInteractionEnabled = false
                        
                        print("Successfully converted cleaned price: \(totalPrice)")
                    } else {
                        itemPriceLabel.text = "$\(itemPriceString)"
                        totalPriceTextField.text = "Price not available"
                        print("Error: Unable to convert item price after cleaning: \(cleanedString)")
                    }
                }
            } else {
                itemPriceLabel.text = "Price not available"
                totalPriceTextField.text = "Price not available"
                print("Error: No price found in UserDefaults")
            }
        } else {
            // Handle case where item details are not available in UserDefaults
            itemNameLabel.text = "Item not available"
            itemPriceLabel.text = "Price not available"
            itemImageView.image = UIImage(named: "placeholderImage")
            totalPriceTextField.text = "Total: N/A"
            print("Error: Could not retrieve item details from UserDefaults")
        }
    }
    
    // You might want to add a Place Order button function here
    @IBAction func placeOrderButtonTapped(_ sender: UIButton) {
        // Show a confirmation alert
        let alert = UIAlertController(title: "Order Placed",
                                     message: "Your order has been placed successfully!",
                                     preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Clear the cart data
            UserDefaults.standard.removeObject(forKey: "cartItemName")
            UserDefaults.standard.removeObject(forKey: "cartItemPrice")
            UserDefaults.standard.removeObject(forKey: "cartItemImage")
            
            // Navigate back to the home screen or appropriate screen
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func submitOrderButtonTapped(_ sender: UIButton) {
        // Show a confirmation alert
        let alert = UIAlertController(title: "Order Placed",
                                     message: "Your order has been placed successfully!",
                                     preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Clear the cart data
            UserDefaults.standard.removeObject(forKey: "cartItemName")
            UserDefaults.standard.removeObject(forKey: "cartItemPrice")
            UserDefaults.standard.removeObject(forKey: "cartItemImage")
            
            // Navigate back to the home screen or appropriate screen
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
}
