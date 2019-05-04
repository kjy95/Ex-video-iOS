//
//  VideoLauncher.swift
//  Ex-video-iOS
//
//  Created by 김지영 on 04/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerView:UIView{
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    func playVideoURL(url: NSURL){
        let player = AVPlayer(url: url as URL)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        player.play()
    } 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher: NSObject {
    func showVideoPlayer(url: NSURL){
        //nsurl??
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.black
            //
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            videoPlayerView.playVideoURL(url: url)
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
        }
        
    }
}
