//
//  CardInfoViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on  2/16/25.
//

// CardInfoViewController.swift
import UIKit

class CardInfoViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc func saveButtonTapped() {
        // Once the save button is tapped, we navigate to PlaceOrderViewController

        // Retrieve saved data from UserDefaults
        if let contactInfo = UserDefaults.standard.string(forKey: "contactInfo"),
           let name = UserDefaults.standard.string(forKey: "name"),
           let address = UserDefaults.standard.string(forKey: "address"),
           let country = UserDefaults.standard.string(forKey: "country") {

            // Pass the details to PlaceOrderViewController
            if let placeOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaceOrderViewController") as? PlaceOrderViewController {
                
                // Pass the data to PlaceOrderViewController
                placeOrderVC.contactInfo = contactInfo
                placeOrderVC.name = name
                placeOrderVC.address = address
                placeOrderVC.country = country

                // Push PlaceOrderViewController to show the order details
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(placeOrderVC, animated: true)
                } else {
                    self.present(placeOrderVC, animated: true, completion: nil)
                }
            } else {
                print("Error: PlaceOrderViewController not found in storyboard.")
            }
        }
    }
}
