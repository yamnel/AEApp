//
//  MainMenuViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 2/21/17.
//  Copyright © 2017. All rights reserved.
//  Edited by Stephen Lomangino, James Hall and Yamnel Serra
//

import UIKit
import SafariServices
import Firebase
import FirebaseAuth

class MainMenuViewController: UIViewController, SFSafariViewControllerDelegate {
    
    
    //Creates a reference with which to connect to the Firebase DB
    let ref  : FIRDatabaseReference! = FIRDatabase.database().reference()
    
    // The following delegate method ensures that the View Controller conforms to
    // SFSafariViewDelagate interface
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    /*
     * Looks up the current user's first & last name
     * and updates the nameLabel with those values
     */
    func readName(){
        
        //Sets a userID variable equal to the current user's ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        //Gets the current user's first and last name and updates the nameLabel with those values
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let firstName = value?["firstName"] as? String ?? ""
            
            let lastName = value?["lastName"] as? String ?? ""
            
            self.nameLabel.text = firstName + " " + lastName

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /*
     * Logs the user out of the Firebase DB and
     * Segues to the Login Screen when the logOutButton is pressed
     */
    @IBAction func logOutButton(_ sender: Any) {
        
        do{
            
            try FIRAuth.auth()?.signOut()
            
        } catch let logoutError{
            
            print(logoutError)
        }
        
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    // Opens a SFSafariViewController object when the Current Deals Button is pressed
    @IBAction func openDealsUrl(_ sender: Any) {
        
        // Creates an SFSafariViewController object with A & E's
        // "Current Deals" Page set as the target url
        let safariVC = SFSafariViewController(url: NSURL(string: "http://aandeautorepair.com/current-deals")! as URL)
        
        //Causes the safariVC to present on screen
        self.present(safariVC, animated: true, completion: nil)
        
        safariVC.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readName()

//         LoginController.currentUser.parsePaymentDates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
