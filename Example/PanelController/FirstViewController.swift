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
		self.panelController?.setPanel(side: .left, !sender.isSelected ? .opened : .closed, animated: self.animationsSwitch.isOn)
    }
    
    @IBAction func rightButtonHandler(sender: UIButton) {
        self.panelController?.setPanel(side: .right, !sender.isSelected ? .opened : .closed, animated: self.animationsSwitch.isOn)
    }

    @IBAction func segmentedControllerValueDidChange(sender: UISegmentedControl) {
        self.panelController?.leftPanelStyle = sender.selectedSegmentIndex == 0 ? .above : .sideBySide
        self.panelController?.rightPanelStyle = sender.selectedSegmentIndex == 0 ? .above : .sideBySide
    }
	
    internal func panelController(_ panelController: PanelController, willChangePanel side: PanelController.PanelSide, toState state: PanelController.PanelState) {
		print("\(#function) in \(type(of: self))")
    }
    
    internal func panelController(_ panelController: PanelController, didChangePanel side: PanelController.PanelSide, toState state: PanelController.PanelState) {
		print("\(#function) in \(type(of: self))")
        
        switch side {
        case .left:
            self.leftButton.isSelected = (state == .opened)
        case .right:
            self.rightButton.isSelected = (state == .opened)
        }
    }
    
    internal func panelController(_ panelController: PanelController, willChangeSizeOfPanel side: PanelController.PanelSide) {
		print("\(#function) in \(type(of: self))")
    }
    
    internal func panelController(_ panelController: PanelController, didChangeSizeOfPanel side: PanelController.PanelSide) {
		print("\(#function) in \(type(of: self))")
    }

}
