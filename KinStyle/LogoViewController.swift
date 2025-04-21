//
//  LogoViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class LogoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the logo screen with a background color and logo image
        self.view.backgroundColor = .white
        let logoImageView = UIImageView(image: UIImage(named: "KinStyle"))
        logoImageView.center = self.view.center
        self.view.addSubview(logoImageView)

        // Transition to Welcome Screen after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.transitionToWelcomeScreen()
        }
    }
    
    func transitionToWelcomeScreen() {
        // Create an instance of the PageViewController and set it as the root view controller
        if let window = view.window {
            let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            window.rootViewController = pageVC
            window.makeKeyAndVisible()
        }
    }
}
