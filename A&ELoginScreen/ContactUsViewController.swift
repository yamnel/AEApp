//
//  ContactUsViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/10/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    let number = "9426273111"

    @IBAction func callUsButton(_ sender: UIButton) {
        
        guard let number = URL(string: "telprompt://" + number) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
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
