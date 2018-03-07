//
//  VideoLaucher.swift
//  YouTube
//
//  Created by MAC on 3/6/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = true
    
    @objc private func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let videosSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc private func handleSliderChange() {
        print(videosSlider.value)
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videosSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completeSeek) in
                
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        addSubview(controlsContainerView)
        controlsContainerView.frame = frame
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videosSlider)
        videosSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videosSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videosSlider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videosSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = .black
        
    }
    
    fileprivate func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLaucher: NSObject {
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 * 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
