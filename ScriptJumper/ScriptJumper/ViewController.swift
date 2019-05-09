//
//  ViewController.swift
//  Ex-video-iOS
//
//  Created by 김지영 on 03/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
import AVKit
import Firebase
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func playInternalVideoBtn(_ sender: Any) {
        /*let filePath:String? = Bundle.main.path(forResource: "tokyoSkyTree", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
        let playVideoView = VideoLauncher()
        //nsurl -> url 변환해야 실행됨
        playVideoView.showVideoPlayer(url: url as URL)
    //https://firebasestorage.googleapis.com/v0/b/arirang-23bb8.appspot.com/o/y2mate.com%20-%20ariana_grande_7_rings_cover_by_jfla_-tm4gC26VgA_1080p.mp4?alt=media&token=b930cb9f-8482-4c8e-b671-8a08edad4098
        if let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4"){//web 전체가 아닐 영상 파일만 링크로
            let playVideoView = VideoLauncher()
            playVideoView.showVideoPlayer(url: url as URL)
        }
         */
        // Create a reference to the file you want to download
        let storage = Storage.storage()
        let gsReference = storage.reference(forURL: "gs://arirang-23bb8.appspot.com")
        let starsRef = gsReference.child("y2mate.com - ariana_grande_7_rings_cover_by_jfla_-tm4gC26VgA_1080p.mp4")
        
        // Fetch the download URL
        starsRef.downloadURL { url, error in
            if let error = error {
                print(error)
            } else{
                print("ok")
                let playVideoView = VideoLauncher()
                playVideoView.showVideoPlayer(url: url!)
                
            }
        }
        
    }
}

