//
//  SettingsPageController.swift
//  A&ELoginScreen
//
//  Created & Edited By J. Tyler Hall, Yamnel Serra, and Stephen Lynch
//   on 3/10/17
//

import UIKit
import FirebaseAuth

class SettingsPageController: UIViewController {
    
    let user = FIRAuth.auth()?.currentUser
    var credential: FIRAuthCredential?
    
    //User input used to reset password
    @IBOutlet weak var emailInput: UITextField!
    
    //User input for desired new email
    @IBOutlet weak var newEmailInput: UITextField!
    
    @IBAction func setNewEmail(_ sender: Any) {
        
//        //Creates a UIAlertController which will display the error
//        let authAlertController = UIAlertController(title: "Re-Enter Credentials", message:
//            "You must re-enter your login credentials in order to change your primary email address.", preferredStyle: UIAlertControllerStyle.alert)
//        
//        //Specifies the text and behavior of the button attached to the UIAlertController
//        authAlertController.addAction(UIAlertAction(title: "Go To Login", style: UIAlertActionStyle.default,handler:
//            {(alert: UIAlertAction!) in
//                        
//                        self.performSegue(withIdentifier: "backToLogin", sender: self)
//                
//        }))
//
//        
//        //Specifies the text and behavior of the button attached to the UIAlertController
//        authAlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
//        
//        
//        
//        self.present(authAlertController, animated: true, completion: nil)
//
//        
//        user?.reauthenticate(with: LoginController.credential!) { error in
//            if error != nil {
//                
//                
//                
//            } else {
//                // User re-authenticated.
//        
//                // Native Firebase function for updating user's email address
//        FIRAuth.auth()?.currentUser?.updateEmail(self.newEmailInput.text!) {
//                (error) in
//            
//                if error != nil{
//                    
//                    //Creates a UIAlertController which will display the error
//                    let setFailureAlertController = UIAlertController(title: "Email  Reset Failed", message:
//                        error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
//                        
//                    //Specifies the text and behavior of the button attached to the UIAlertController
//                    setFailureAlertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
//                    
//                        
//                    self.present(setFailureAlertController, animated: true, completion: nil)
//                
//                } else {
//                        
//                    //Creates a UIAlertController which will display the error
//                    let setSuccessAlertController = UIAlertController(title: "Success!", message:
//                        "Your new email address has been set! You will receive an email confirming this change.", preferredStyle: UIAlertControllerStyle.alert)
//                        
//                    //Specifies the text and behavior of the button attached to the UIAlertController
//                    setSuccessAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
//                }
//                }
//            }
//        }
    }
    
    @IBAction func sendPasswordReset(_ sender: Any) {
        
        //Native Firebase function to reset user's password via reset email
        FIRAuth.auth()?.sendPasswordReset(withEmail: emailInput.text!, completion: { (error) in
            
            if error != nil{
                
                //Creates a UIAlertController which will display the error
                let resetFailureAlertController = UIAlertController(title: "Password Reset Failed", message:
                    error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                
                //Specifies the text and behavior of the button attached to the UIAlertController
                resetFailureAlertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                
                //Causes the UIAlertController to pop up on screen
                self.present(resetFailureAlertController, animated: true, completion: nil)
                
            } else{
                
                //Creates a UIAlertController which tell the user that
                //the attempt succeeded
                let resetSuccessAlertController = UIAlertController(title: "Success!", message:
                    "A password reset message has been sent to your email address!", preferredStyle: UIAlertControllerStyle.alert)
                
                //Specifies the text and behavior of the button attached to the UIAlertController
                resetSuccessAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {(alert: UIAlertAction!) in
                    
                    //Checks to make sure that the user is signed in
                    FIRAuth.auth()?.addStateDidChangeListener { auth, user in
                        if user != nil {
                            // User is signed in, and is therefore
                            // redirected to the main menu
                            
                            self.performSegue(withIdentifier: "backToMain", sender: self)
                        } else {
                            // No user is signed in, so the user is
                            // Redirected to the login screen to do so
                            
                            self.performSegue(withIdentifier: "backToLogin", sender: self)
                        }
                    }
                    
                }))
                //Causes the UIAlertController to pop up on screen
                self.present(resetSuccessAlertController, animated: true, completion: nil)
                
            }
        })
    }
    @IBAction func cancelAction(_ sender: Any) {
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil {
                // User is signed in, so they are redirected to main menu
                
                self.performSegue(withIdentifier: "backToMain", sender: self)
            } else {
                // No user is signed in, so they are
                // redirected to the login screen
                
                self.performSegue(withIdentifier: "backToLogin", sender: self)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
