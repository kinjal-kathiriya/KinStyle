//
//  OptionsViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class OptionsViewController: UIViewController {

    // UI Elements
    @IBOutlet weak var celebrityOutfitButton: UIButton!
    @IBOutlet weak var trendingFashionStyleButton: UIButton!
    @IBOutlet weak var aiGeneratedOutfitButton: UIButton!
    @IBOutlet weak var changeOutfitLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Setup navigation bar with back button
        setupBackButton()
    }

    // Back Button - to navigate back from this screen
    private func setupBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward.circle"), // SF Symbol
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        backButton.tintColor = .brown
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation Methods

    private func navigateToUploadPhotoScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uploadPhotoVC = storyboard.instantiateViewController(withIdentifier: "Uploadphotoviewcontroller") as? Uploadphotoviewcontroller {
            
            uploadPhotoVC.modalPresentationStyle = .fullScreen // No navigation bar or back button
            present(uploadPhotoVC, animated: true, completion: nil)
        } else {
            print("⚠️ Error: Could not load Uploadphotoviewcontroller. Check Storyboard ID.")
        }
    }

    @IBAction func celebrityOutfitButtonTapped(_ sender: UIButton) {
        print("Celebrity Outfit Button Tapped!")
        navigateToUploadPhotoScreen()
    }

    @IBAction func trendingFashionStyleButtonTapped(_ sender: UIButton) {
        print("Trending Fashion Style Button Tapped!")
        navigateToUploadPhotoScreen()
    }

    @IBAction func aiGeneratedOutfitButtonTapped(_ sender: UIButton) {
        print("AI Generated Outfit Button Tapped!")
        navigateToUploadPhotoScreen()
    }

    @IBAction func changeOutfitLabelTapped(_ sender: UITapGestureRecognizer) {
        print("Change Outfit Label Tapped!")
        navigateToUploadPhotoScreen()
    }
}
