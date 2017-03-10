//
//  ContactUsViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/10/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let number = "9416273111"
    var facebookLink = "facebook://profile/147188581990505"
 

    @IBAction func callUsButton(_ sender: UIButton) {
        
        guard let number = URL(string: "telprompt://" + number) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
        let facebookUrl = URL(string: facebookLink)
        
        let options = [UIApplicationOpenURLOptionUniversalLinksOnly : true]
        
        
        if UIApplication.shared.canOpenURL(facebookUrl! as URL)
        {
            UIApplication.shared.open(facebookUrl!, options: options, completionHandler: nil)
            
        } else {
            //redirect to safari because the user doesn't have Facebook
            UIApplication.shared.open(NSURL(string: "https://www.facebook.com/aandeautorepair/")! as URL)
        }
        
    }
    
    @IBAction func mailButton(_ sender: UIButton) {
        
        /*If the MailComposeViewController is able to send mail,
         * A MFMailComposeViewController object is created and
         * An email composition dialog pops up, with
         * aandeautorepair@yahoo.com set as the recipient
         * If the MailComposeViewController is able to send mail, an 
         * error message is printed and the attempt closes
         */
        if MFMailComposeViewController.canSendMail() {
            
            let mailer = MFMailComposeViewController()
            mailer.mailComposeDelegate = self
            mailer.setToRecipients(["aandeautorepair@yahoo.com"])
            mailer.setMessageBody("<p>Please enter your message here</p>", isHTML: true)
            
            present(mailer, animated: true)
        
        } else {
            print("Mail services are not available")
            return
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
