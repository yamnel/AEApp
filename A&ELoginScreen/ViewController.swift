//
//  ViewController.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 2/7/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//  Edited by Tyler Hall (A WHOLE Lot)
//

import UIKit
import FirebaseAuth


extension UINavigationController {
    override open var shouldAutorotate: Bool {
        return false
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
        //Stores the user-entered email & password values into variables using the guard statement
        //which checks to ensure that the String optionals have a value present
        guard let email = emailField.text, let password = passwordField.text
            
            else {
                
                return
            }
        
        //Attempts to sign the user in to the app using the supplied credentials
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            //If an error has been caught
            if error != nil{
                
                //Creates a UIAlertController which will display the error
                let loginFailureAlertController = UIAlertController(title: "Login Failure", message:
                    error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                
                //Specifies the text and behavior of the button attached to the UIAlertController
                loginFailureAlertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                
                //Causes the controller to display on-screen with animation
                self.present(loginFailureAlertController, animated: true, completion: nil)
            }
            
                
//                //Creates a UIAlertController which will display login success confirmation
//                let loginSuccessAlertController = UIAlertController(title: "Login Successful!", message:
//                    "", preferredStyle: UIAlertControllerStyle.alert)
//                
//                //Specifies the text and behavior of the button attached to the UIAlertController
//                //Which includes a segue to the Main Menu View
//                loginSuccessAlertController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default,handler: { action in self.performSegue(withIdentifier: "loginSegue", sender: self)}))
                
//                //Causes the controller to display on-screen with animation
//                self.present(loginSuccessAlertController, animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
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

