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
    
    var player :AVPlayer?
    
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
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    var isPlaying = true
    @objc func handlePause(){
        if isPlaying{
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        }else{
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    
    func playVideoURL(url: NSURL){
        player = AVPlayer(url: url as URL)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        player?.play()
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        setIndicatorViewOnCenterAndButton()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
        }
        
    }
    func setIndicatorViewOnCenterAndButton(){
        //activityIndicator
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
