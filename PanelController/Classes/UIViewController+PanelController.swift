//
//  UIViewController+PanelController.swift
//  PanelControllerDemo
//
//  Created by Tanguy Helesbeux on 10/02/2016.
//  Copyright © 2016 HEVA. All rights reserved.
//

import UIKit

public extension UIViewController {
    
	public var panelController: PanelController? { return self.parent as? PanelController }
    
}
