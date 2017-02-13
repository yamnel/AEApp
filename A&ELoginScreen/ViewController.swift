//
//  ViewController.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 2/7/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit


extension UINavigationController {
    override open var shouldAutorotate: Bool {
        return false
    }
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

