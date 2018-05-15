//
//  PageViewController.swift
//  Test page control
//
//  Created by Tiago Do Couto on 5/14/18.
//  Copyright © 2018 coutocode. All rights reserved.
//

import UIKit

protocol PageDelegate {
    func changedView(index: Int)
}

class PageViewController: UIPageViewController
{
    var pageDelegate: PageDelegate?
    
    var selectedIndex = 0
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "Page1"),
            self.getViewController(withIdentifier: "Page2"),
            self.getViewController(withIdentifier: "Page3")
        ]}()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func changeView(index: Int){
        var direction: UIPageViewControllerNavigationDirection
        
        if index > selectedIndex {
            direction = .forward
        }else{
            direction = .reverse
        }
        selectedIndex = index
         setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        if (viewControllerIndex > 0){
            selectedIndex = viewControllerIndex-1
            return pages[selectedIndex]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        if (viewControllerIndex < pages.count-1){
            selectedIndex = viewControllerIndex+1
            return pages[selectedIndex]
        }
        return nil
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let viewControllerIndex = pageViewController.viewControllers?.first?.view.tag else { return }
            pageDelegate?.changedView(index: viewControllerIndex)
        }
    }
}

