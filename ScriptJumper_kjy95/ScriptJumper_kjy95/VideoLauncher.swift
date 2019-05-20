//
//  VideoLauncher.swift
//  Ex-video-iOS
//
//  Created by 김지영 on 04/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView:UIView{
    
    var player :AVPlayer?
    var subtitle: SmiParser!
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
    
    let videoLentghLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
    }()
    @objc func handleSliderChange(){
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: {(completedSeek) in
                
            })
            
        }
        
    }
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "back")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    @objc func handleBack(){
        
        print("asdf")
        
        let window = UIApplication.shared.keyWindow!
        if let view = window.viewWithTag(100) {
            view.removeFromSuperview()
        }
        print("asdf")
    }
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
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    
    func playVideoURL(url: URL, jumpTime: String){
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        player?.play()
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        setIndicatorViewOnCenterAndButton()
            
        let timeList = jumpTime.split(separator: ":")
            
        var seconds = 0
        if let hour = Int(timeList[0]){
            seconds = hour*60*60
        }
        if let min = Int(timeList[1]){
            seconds += min*60
        }
        if let sec = Int(timeList[2]){
            seconds += sec
        }
            
        self.videoSlider.value = Float(seconds/Int(self.videoSlider.maximumValue))
            
            
        let seekTime = CMTime(value: Int64(seconds), timescale: 1)
            player?.seek(to: seekTime)
            
        
        
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let secondString = String(format: "%02d", Int(seconds) % 60)
            let minuteString = String(format: "%02d", Int(seconds / 60))
            let timeString = String(format: "%02d", Int(seconds / 60)/60)
            self.currentTimeLabel.text = "\(minuteString):\(secondString)"
            // subtitle
            for i in Range(0...self.subtitle.clockList.count-1){
                if self.subtitle.clockList[i] == "\(timeString):\(minuteString):\(secondString)"{
                    self.subtitleLabel.attributedText = self.subtitle.subtitleListWithTag![i].htmlAttributedString()
                    self.subtitleLabel.textAlignment = .center
                    self.subtitleLabel.textColor = .white
                    self.subtitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                    self.subtitleLabel.backgroundColor = UIColor(white: 000, alpha: 0.5)
                    
                    print(self.subtitle.subtitleListWithTag![i])
                }
            }

            //move slider thumb
            if let duration = self.player?.currentItem?.duration{
                let durationSecond = CMTimeGetSeconds(duration)
                self.videoSlider.value = Float(seconds/durationSecond)
                
            }
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            //time label
            if let duration = player?.currentItem?.duration{
                
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = String(format:"%02d", Int(seconds) % 60)
                let minutesText = String(format:"%02d", Int(seconds) / 60 % 60 )
                let hoursText = String(format:"%02d", Int(seconds) / 60 / 60)
                videoLentghLabel.text = "\(hoursText):\(minutesText):\(secondsText)"
                
            }
            
        }
        
    }
    func setIndicatorViewOnCenterAndButton(){
        //activityIndicator
        setupGradientLayer()
        
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
        
        //label
        controlsContainerView.addSubview(videoLentghLabel)
        videoLentghLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        videoLentghLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        videoLentghLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        videoLentghLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //slider
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLentghLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //subtitle
        controlsContainerView.addSubview(subtitleLabel)
        subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: videoLentghLabel.topAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        //backbutton
        controlsContainerView.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    private func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.8, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class VideoLauncher: NSObject {
    
    var parser: SmiParser?
    
    func showVideoPlayer(url: URL,jumperTime: String){
        //nsurl??
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.tag = 100
            view.backgroundColor = UIColor.black
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            if let subtitle = parser {
                videoPlayerView.subtitle = subtitle
                videoPlayerView.playVideoURL(url: url, jumpTime: jumperTime)
            }
            
            
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
            
        }
        
    }
}
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
}
 
