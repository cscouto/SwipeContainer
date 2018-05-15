//
//  ViewController.swift
//  Test page control
//
//  Created by Tiago Do Couto on 5/14/18.
//  Copyright © 2018 coutocode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segView: UISegmentedControl!
    var pageVC: PageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPageController" {
            pageVC = segue.destination as? PageViewController
            pageVC?.pageDelegate = self
        }
    }
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        pageVC?.changeView(index: sender.selectedSegmentIndex)
    }
}

extension ViewController: PageDelegate {
    func changedView(index: Int) {
        segView.selectedSegmentIndex = index
    }
}

