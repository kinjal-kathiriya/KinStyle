//
//  AddToCartViewController.swift
//  KinStyle
//
//  Created by Kinjal Kathiriya on 2/16/25.
//
import UIKit

class AddToCartViewController: UIViewController {

    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!  // Added text field for price
    @IBOutlet weak var checkoutButton: UIButton!  // Added checkout button

    // Properties to store the image and details
    var selectedImage: UIImage?
    var outfitName: String?
    var outfitPrice: String?
    var outfitSize: String?
    var outfitColor: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UI with the passed data
        cartImageView.image = selectedImage
        nameLabel.text = outfitName ?? "No name"
        priceLabel.text = outfitPrice ?? "No price"
        sizeLabel.text = outfitSize ?? "No size"
        colorLabel.text = outfitColor ?? "No color"

        // Set price in the text field
        priceTextField.text = outfitPrice ?? "No price"
        priceTextField.isUserInteractionEnabled = false  // Make it read-only

        // Save the item data into UserDefaults when the item is added to the cart
        saveItemToCart()

        // Set up the checkout button action
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)

        // Call setupBackButton to add the back button
        setupBackButton()
    }

    private func saveItemToCart() {
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8), // Use JPEG instead of PNG to reduce size
              let name = outfitName,
              let price = outfitPrice else {
            print("Error: Missing item details while saving to cart")
            return
        }

        // Debug print for saving item details
        print("Saving item: \(name), Price: \(price)")
        
        // Process the price string to remove currency symbols
        let numericPrice = price.replacingOccurrences(of: "$", with: "")
        
        // Save item details to UserDefaults
        UserDefaults.standard.set(name, forKey: "cartItemName")
        UserDefaults.standard.set(numericPrice, forKey: "cartItemPrice") // Save numeric value only
        UserDefaults.standard.set(imageData.base64EncodedString(), forKey: "cartItemImage")
        
        UserDefaults.standard.synchronize()  // Ensure the data is saved
    }

    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.backward.circle.fill")
        
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .brown
        backButton.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(backButton)

        // Auto Layout constraints for back button
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func backButtonTapped() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc func checkoutButtonTapped() {
        // Ensure that PaymentMethodViewController is available
        guard let paymentMethodVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentMethodViewController") as? PaymentMethodViewController else {
            print("Error: Could not instantiate PaymentMethodViewController from storyboard")
            return
        }

        // Check if we have a navigation controller and push
        if let navigationController = self.navigationController {
            navigationController.pushViewController(paymentMethodVC, animated: true)
        } else {
            // Fallback: Present modally if not in a navigation controller
            present(paymentMethodVC, animated: true, completion: nil)
            print("Warning: No navigation controller found, presenting modally instead")
        }
    }
}
