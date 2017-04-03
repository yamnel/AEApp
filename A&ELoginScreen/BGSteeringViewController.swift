//
//  BGSteeringViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/27/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class BGSteeringViewController: UIViewController {
    
    

    @IBOutlet weak var steeringVideo: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo(videoCode: "pQhNfv3ry_U")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        steeringVideo.loadRequest(URLRequest(url: videoURL!))
    }

}
