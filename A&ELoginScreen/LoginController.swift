//
//  ViewController.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 2/7/17.
//  Copyright © 2017. All rights reserved.
//  Edited by Stephen Lomangino, James Hall and Yamnel Serra
//

import UIKit
import FirebaseAuth


extension UINavigationController {
    override open var shouldAutorotate: Bool {
        return false
    }
}

class LoginController: UIViewController {
    
    static var credential:FIRAuthCredential?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
        //Stores the user-entered email & password values into variables using the guard statement
        //which checks to ensure that the String optionals have a value present
        guard let email = emailField.text, let password = passwordField.text
            
            else {
                
                return
            }
                // No user is signed in.
            
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
            //an uninterrupted transition from this screen to the login screen
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

//    static var currentUser: UserInformation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creates an instance of the UserInformation class & stores into the current user
//        LoginController.currentUser = UserInformation()

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

