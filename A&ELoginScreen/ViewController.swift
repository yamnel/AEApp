//
//  ViewController.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 2/7/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//  Edited by Tyler Hall (A WHOLE Lot)
//

import UIKit


extension UINavigationController {
    override open var shouldAutorotate: Bool {
        return false
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginButton(_ sender: Any) {
    }
    @IBAction func signupButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

