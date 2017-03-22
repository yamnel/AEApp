//
//  BGBrakeViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 3/18/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit

class BGBrakeViewController: UIViewController {

    @IBOutlet weak var brakeVideo: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: "e1GzCHZYgk0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        
        let videoURL = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        brakeVideo.loadRequest(URLRequest(url: videoURL!))
        
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
