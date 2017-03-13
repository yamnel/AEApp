////
////  CurrentDealsViewController.swift
////  A&ELoginScreen
////
////  Created by James Hall on 3/11/17.
////  Copyright © 2017 Yamnel. All rights reserved.
////
//
//import UIKit
//
//class CurrentDealsViewController: UIViewController, SFSafariViewControllerDelegate {
//    
//    
//    
//    @IBOutlet weak var dealsView: UIWebView!
//
//    func safariViewControllerDidFinish(controller: SFSafariViewController)
//    {
//        controller.dismissViewControllerAnimated(true, completion: nil)
//    }
//
//    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
//        
//        dealsView.reload()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        safariVC.delegate = self
//        let safariVC = SFSafariViewController(URL: NSURL(string: "http://apple.com")!)
//        self.presentViewController(safariVC, animated: true, completion: nil)
//
//       
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
