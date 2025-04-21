//
//  Uploadphotoviewcontroller.swift
//  KinStyle
//
//  Created by kinjal kathiriya on 2/16/25.
//

import UIKit
import AVFoundation
import Photos

class Uploadphotoviewcontroller: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    private var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false  // Disable editing to avoid extra cropping screen
        
        // Hide back button
        navigationItem.hidesBackButton = true

        // Add gesture to tap image view to upload photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadImageTapped))
        uploadImageView.isUserInteractionEnabled = true
        uploadImageView.addGestureRecognizer(tapGesture)
    }

    // Show action sheet to choose between camera or gallery
    @objc private func uploadImageTapped() {
        let alertController = UIAlertController(title: "Choose Option", message: "Select a photo from Camera or Gallery", preferredStyle: .actionSheet)

        // Add option for Camera
        alertController.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.openCamera()
        }))
        
        // Add option for Gallery
        alertController.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: { [weak self] _ in
            self?.openPhotoGallery()
        }))
        
        // Add Cancel option
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present action sheet
        present(alertController, animated: true, completion: nil)
    }

    // Open Camera if available and handle permissions
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)

            switch cameraStatus {
            case .authorized:
                imagePicker.sourceType = .camera
                present(imagePicker, animated: true)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    DispatchQueue.main.async {
                        if granted {
                            self?.imagePicker.sourceType = .camera
                            self?.present(self!.imagePicker, animated: true)
                        } else {
                            self?.showPermissionAlert(message: "Camera access denied. Please enable it in Settings.")
                        }
                    }
                }
            case .denied, .restricted:
                showPermissionAlert(message: "Camera access denied. Please enable it in Settings.")
            default:
                break
            }
        } else {
            showPermissionAlert(message: "Camera is not available on this device.")
        }
    }

    // Open Photo Library if available and handle permissions
    private func openPhotoGallery() {
        let photoStatus = PHPhotoLibrary.authorizationStatus()

        switch photoStatus {
        case .authorized:
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self?.imagePicker.sourceType = .photoLibrary
                        self?.present(self!.imagePicker, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showPermissionAlert(message: "Photo library access denied. Please enable it in Settings.")
                    }
                }
            }
        case .denied, .restricted:
            showPermissionAlert(message: "Photo library access denied. Please enable it in Settings.")
        default:
            break
        }
    }

    // Handle selected image from picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            uploadImageView.image = selectedImage
            
            // Show options for selected image and all images
            showImageOptions(selectedImage: selectedImage)
            
            // Wait for 1.5 seconds before navigating to the next screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.navigateToBoyCelebrityOutfitsViewController()
            }
        }
        
        // Dismiss image picker
        dismiss(animated: true, completion: nil)
    }

    // Transition to BoyCelebrityOutfitsViewController
    private func navigateToBoyCelebrityOutfitsViewController() {
        // Ensure that the view controller ID is correct in the storyboard
        if let boyCelebrityOutfitsVC = storyboard?.instantiateViewController(withIdentifier: "BoyCelebrityOutfitsViewController") {
            
            // Check if you're using a navigation controller
            if let navigationController = self.navigationController {
                navigationController.pushViewController(boyCelebrityOutfitsVC, animated: true)
            } else {
                // If not using a navigation controller, present modally
                self.present(boyCelebrityOutfitsVC, animated: true, completion: nil)
            }
        } else {
            print("Error: BoyCelebrityOutfitsViewController not found in storyboard.")
        }
    }

    // Show options after selecting an image
    private func showImageOptions(selectedImage: UIImage) {
        let alertController = UIAlertController(title: "Select Option", message: "Choose Selected Image or All Images", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Selected Image", style: .default, handler: { [weak self] _ in
            self?.uploadImageView.image = selectedImage
        }))
        
        alertController.addAction(UIAlertAction(title: "All Images", style: .default, handler: { [weak self] _ in
            self?.showAllImages()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }

    // Show all images (you can customize this as per your need)
    private func showAllImages() {
        // Implement logic to show all images in gallery
        print("Show all images in gallery...")
        // You can implement your custom gallery view or present another picker here
    }

    // Handle cancel action from picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // Show alert for permissions
    private func showPermissionAlert(message: String) {
        let alert = UIAlertController(title: "Permission Denied", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
