//
//  FirstViewController.swift
//  PanelControllerDemo
//
//  Created by Tanguy Helesbeux on 10/02/2016.
//  Copyright © 2016 Tanguy Helesbeux. All rights reserved.
//

import UIKit
import PanelController

class FirstViewController: ViewController, PanelControllerDelegate {
    
    @IBOutlet weak var animationsSwitch: UISwitch!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    init() {
        super.init(nibName: "FirstViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.panelController?.delegate = self
    }
    
    @IBAction func leftButtonHandler(sender: UIButton) {
        self.panelController?.setPanel(.Left, !sender.selected ? .Opened : .Closed, animated: self.animationsSwitch.on)
    }
    
    @IBAction func rightButtonHandler(sender: UIButton) {
        self.panelController?.setPanel(.Right, !sender.selected ? .Opened : .Closed, animated: self.animationsSwitch.on)
    }

    @IBAction func segmentedControllerValueDidChange(sender: UISegmentedControl) {
        self.panelController?.leftPanelStyle = sender.selectedSegmentIndex == 0 ? .Above : .SideBySide
        self.panelController?.rightPanelStyle = sender.selectedSegmentIndex == 0 ? .Above : .SideBySide
    }
    
    internal func panelController(panelController: PanelController, willChangePanel side: PanelController.PanelSide, toState state: PanelController.PanelState) {
        print("\(#function) in \(self.dynamicType)")
    }
    
    internal func panelController(panelController: PanelController, didChangePanel side: PanelController.PanelSide, toState state: PanelController.PanelState) {
        print("\(#function) in \(self.dynamicType)")
        
        switch side {
        case .Left:
            self.leftButton.selected = (state == .Opened)
        case .Right:
            self.rightButton.selected = (state == .Opened)
        }
    }
    
    internal func panelController(panelController: PanelController, willChangeSizeOfPanel side: PanelController.PanelSide) {
        print("\(#function) in \(self.dynamicType)")
    }
    
    internal func panelController(panelController: PanelController, didChangeSizeOfPanel side: PanelController.PanelSide) {
        print("\(#function) in \(self.dynamicType)")
    }

}
