//
//  BGDrivelineViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/20/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class BGDrivelineViewController: UIViewController {

    @IBOutlet weak var drivelineVideo: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: "e-EdBSAOyZg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        drivelineVideo.loadRequest(URLRequest(url: videoURL!))
    }
}
