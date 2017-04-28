//
//  SettingsPageController.swift
//  A&ELoginScreen
//
//  Created & Edited By J. Tyler Hall, Yamnel Serra, and Stephen Lomangino
//   on 3/10/17
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsPageController: UIViewController {
    
    let user = FIRAuth.auth()?.currentUser
    
    var credential: FIRAuthCredential?
    
    //User input used to reset password
    @IBOutlet weak var emailInput: UITextField!

    //User input for desired new email
    @IBOutlet weak var newEmailInput: UITextField!
    
    /*
     * Function allows the user to set a new email to be
     * associated with their account
     */
    @IBAction func setNewEmail(_ sender: Any) {
        //Native firebase to update authorization sector of db
        user?.updateEmail(newEmailInput.text!) { (error) in
            if error != nil {
                
                //reset failed
                let resetFailureAlertController = UIAlertController(title: "Email update FAILED", message: error?.localizedDescription, preferredStyle:UIAlertControllerStyle.alert)
                
                //Specifies the text and behavior of the button attached to the UIAlertController
                resetFailureAlertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(resetFailureAlertController, animated: true, completion: nil)
            } else {
                //reset succeeded
                var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
                ref = FIRDatabase.database().reference()
                
                //update email field in the db
                ref.child("users").child((self.user?.uid)!).updateChildValues(["email" : self.newEmailInput.text!])
                
                //Creates a UIAlertController which tell the user that the reset succeeded
                let resetSuccessAlertController = UIAlertController(title: "Success!", message:
                    "A confirmation message has been sent to your email address!", preferredStyle: UIAlertControllerStyle.alert)
                
                //Specifies the text and behavior of the button attached to the UIAlertController
                resetSuccessAlertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
                //send the ui back to the main menu
                self.performSegue(withIdentifier: "backToMain", sender: self)

                //Causes the UIAlertController to pop up on screen
                self.present(resetSuccessAlertController, animated: true, completion: nil) 
            }
        }
    }
    
    /*
     * Function allows the user to set a new password to be
     * associated with their account, which is accomplished
     * by a password reset sent to the user at the
     * completion of this function
     */
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
                
            } else {
                
                //Creates a UIAlertController which tells the user that
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
