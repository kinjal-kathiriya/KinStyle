//
//  GenresViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class GenresViewController: UIViewController {
    
    @IBOutlet weak var boyImageView: UIImageView!
    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var womenImageView: UIImageView!
    @IBOutlet weak var menImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up gesture recognizers for images
        setupImageGestureRecognizers()
    }

    private func setupImageGestureRecognizers() {
        addTapGesture(to: boyImageView, action: #selector(imageTapped))
        addTapGesture(to: girlImageView, action: #selector(imageTapped))
        addTapGesture(to: womenImageView, action: #selector(imageTapped))
        addTapGesture(to: menImageView, action: #selector(imageTapped))
    }
    
    private func addTapGesture(to imageView: UIImageView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }

    @objc func imageTapped() {
        print("Image tapped!")
        navigateToOptionViewController()
    }

    private func navigateToOptionViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let optionsVC = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as? OptionsViewController {
            let navController = UINavigationController(rootViewController: optionsVC)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
        } else {
            print("⚠️ Error: Could not load OptionsViewController. Check Storyboard ID.")
        }
    }
}

