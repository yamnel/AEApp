//
//  InterestFreeViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 4/21/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class InterestFreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func apply(_ sender: UIButton) {
        
        UIApplication.shared.open(NSURL(string: "https://etail.mysynchrony.com/eapply/eapply.action?uniqueId=ABB75F4E7839CB18E21D8DFC208DC369EAF15F97ABA1C619&client=CarCareONE&intcmp=cc1b-keepliferolling-internalapply")! as URL)
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
