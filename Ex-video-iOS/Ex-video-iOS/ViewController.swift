//
//  ViewController.swift
//  Ex-video-iOS
//
//  Created by 김지영 on 03/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func playInternalVideoBtn(_ sender: Any) {
        let filePath:String? = Bundle.main.path(forResource: "tokyoSkyTree", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
        let playVideoView = VideoLauncher()
        playVideoView.showVideoPlayer(url: url)
        
    }
}

