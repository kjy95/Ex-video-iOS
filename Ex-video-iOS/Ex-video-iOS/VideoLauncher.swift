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
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
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
        
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        indicatorViewOnCenter()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
        }
    }
    func indicatorViewOnCenter(){
        //activityIndicator
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
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
