//
//  PageViewController.swift
//  KinStyle
//
//  Created by kinjal kathiriya on 2/16/25.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages: [UIViewController] = []
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Load the welcome view controllers from the storyboard
        let welcome = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        let welcome1 = storyboard.instantiateViewController(withIdentifier: "Welcome1ViewController")
        let welcome2 = storyboard.instantiateViewController(withIdentifier: "Welcome2ViewController")

        // Store the pages in an array
        pages = [welcome, welcome1, welcome2]

        // Set the first view controller in the PageViewController
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        setupPageControl()
    }


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else { return nil }
        return pages[currentIndex + 1]
    }


    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY - 80, width: self.view.frame.width, height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
    }

    // Update page control when transitioning between pages
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let visibleVC = viewControllers?.first, let index = pages.firstIndex(of: visibleVC) {
            pageControl.currentPage = index
        }
    }
}

