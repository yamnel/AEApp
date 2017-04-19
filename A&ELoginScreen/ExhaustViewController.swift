//
//  ExhaustViewController.swift
//  A&ELoginScreen
//
//  Created by Stephen Lomangino on 3/27/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class ExhaustViewController: UIViewController {
    @IBOutlet weak var exhaustVideo: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: "cXGGNiLDoF0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        
        //Specifies the URL of the video to be loaded using the video code that is passed in
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        
        //Loads the video into the UIWebView
        exhaustVideo.loadRequest(URLRequest(url: videoURL!))
    }

}
