//
//  MainMenuViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 2/21/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
import FirebaseAuth

class MainMenuViewController: UIViewController, SFSafariViewControllerDelegate {
    
    
    
    let ref  : FIRDatabaseReference! = FIRDatabase.database().reference()
    
    // The following delegate method ensures that the View Controller conforms to
    // SFSafariViewDelagate interface
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func readName(){
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            
            let firstName = value?["firstName"] as? String ?? ""
            
            let lastName = value?["lastName"] as? String ?? ""
            
//            self.nameLabel.text = firstName + " " + lastName

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    @IBAction func logOutButton(_ sender: Any) {
        
        logOutHandler()
    }
    
    func logOutHandler(){
        
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
        
        self.present(safariVC, animated: true, completion: nil)
        
        safariVC.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readName()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
