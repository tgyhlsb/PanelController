//
//  ThirdViewController.swift
//  PanelControllerDemo
//
//  Created by Tanguy Helesbeux on 10/02/2016.
//  Copyright © 2016 Tanguy Helesbeux. All rights reserved.
//

import UIKit

class ThirdViewController: ViewController {
    
    @IBAction func closeButtonHandler(sender: UIButton) {
        self.panelController?.setPanel(.Right, .Closed, animated: true)
    }
    
    @IBAction func segmentedControllerValueDidChange(sender: UISegmentedControl) {
        self.preferredContentSize.width = 100 + 100.00 * CGFloat(1 + sender.selectedSegmentIndex)
    }

}
