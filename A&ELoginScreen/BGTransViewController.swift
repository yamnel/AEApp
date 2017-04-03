//
//  BGTransViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/27/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class BGTransViewController: UIViewController {

    @IBOutlet weak var transmissionVideo: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo(videoCode: "kxkD_gc_jp0")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        transmissionVideo.loadRequest(URLRequest(url: videoURL!))
        
    }


}
