//
//  ViewController.swift
//  PanelControllerDemo
//
//  Created by Tanguy Helesbeux on 09/02/2016.
//  Copyright © 2016 Tanguy Helesbeux. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
		print("\(#function) in \(type(of: self))")
    }
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		print("\(#function) in \(type(of: self))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) in \(type(of: self))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(#function) in \(type(of: self))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(#function) in \(type(of: self))")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("\(#function) in \(type(of: self))")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("\(#function) in \(type(of: self))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(#function) in \(type(of: self))")
    }
    
}

