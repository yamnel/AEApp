//
//  FuelServiceViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/23/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class FuelServiceViewController: UIViewController {

    @IBOutlet weak var fuelServiceVideo: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo(videoCode: "g-YEZjkhruM")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        fuelServiceVideo.loadRequest(URLRequest(url: videoURL!))
        
    }
}
