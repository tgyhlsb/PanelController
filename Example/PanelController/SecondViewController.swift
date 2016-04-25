//
//  SecondViewController.swift
//  PanelControllerDemo
//
//  Created by Tanguy Helesbeux on 10/02/2016.
//  Copyright © 2016 Tanguy Helesbeux. All rights reserved.
//

import UIKit

class SecondViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeButtonHandler(sender: UIButton) {
        self.panelController?.setPanel(.Left, .Closed, animated: true)
    }
    
    @IBAction func segmentedControllerValueDidChange(sender: UISegmentedControl) {
        self.preferredContentSize.width = 200.00 * CGFloat(1 + sender.selectedSegmentIndex)
    }
}
