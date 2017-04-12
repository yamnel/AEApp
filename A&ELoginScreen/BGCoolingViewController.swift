//
//  BGCoolingViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/20/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class BGCoolingViewController: UIViewController {

    @IBOutlet weak var coolingVideo: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: "hESinaTCKW4")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){

        //Specifies the URL of the video to be loaded using the video code that is passed in
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")

        //Loads the video into the UIWebView
        coolingVideo.loadRequest(URLRequest(url: videoURL!))
    }
}
