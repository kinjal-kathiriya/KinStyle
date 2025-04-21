//
//  Welcome.swift
//  KinStyle
//
//  Created by kinjal kathiriya  on 2/16/25.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("✅ Welcome Screen Loaded")  // Debugging
        
        // Ensure pageControl is not nil
        if let pageControl = pageControl {
            pageControl.currentPage = 0
        } else {
            print("Error: pageControl is nil")
        }
    }
}


