//
//  PlayerViewController.swift
//  TestPlayerShrink
//
//  Created by Martin Lukacs on 04/06/2019.
//  Copyright © 2019 com.plop.plop. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation



class PlayerViewController: UIViewController {

    @IBOutlet weak var playerContainer: UIView!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var miniPlayerBar: UIView!
    
    private var swipeDown: UISwipeGestureRecognizer?
    private var swipeUp: UISwipeGestureRecognizer?
    private var swipeLeft: UISwipeGestureRecognizer?
    private var doubleTap: UITapGestureRecognizer?
    
    private let ipadMiniPlayerHeight: CGFloat = 90.0
    private let ipadMiniPlayerWidth: CGFloat = 160.0
    private let margin: CGFloat = 5.0
    private let duration: TimeInterval = 0.5

    
    var player: AVQueuePlayer!
    var avPlayerController: AVPlayerViewController!
    private var token: NSKeyValueObservation?
    var playerItems = [AVPlayerItem(url: URL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")!),
                       AVPlayerItem(url: URL(string: "https://sdn-global-streaming-cache.3qsdn.com/stream/9378/files/18/12/1067680/9378-yYhz8P4dXGDjxn6H.ism/manifest.m3u8?format=hls&mime=mp4&source=html5")!)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        player = AVQueuePlayer(items: playerItems)
        avPlayerController = AVPlayerViewController()
        avPlayerController.player = player
        avPlayerController.allowsPictureInPicturePlayback = true
        avPlayerController.view.frame = self.playerContainer.bounds;
        avPlayerController.updatesNowPlayingInfoCenter = false
        self.addChild(avPlayerController)
        self.playerContainer.addSubview(avPlayerController.view);
        
        token = player.observe(\.currentItem) { [weak self] player, _ in
            print("Woot this is current item \(player.items().count)")
            
            if player.items().count == 0 {
                player.pause()
                for item in (self?.playerItems)! {
                    print("Woot plop")
                    player.insert(item, after: player.items().last)
                }
                player.pause()
                
            }
        }
        setUpGestures()
    }
    @objc private func actionTapOnScrollView(sender:UITapGestureRecognizer){
        print("cestlamerde")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
//    func displayPlayer() {
//        let vc = UIApplication.shared.keyWindow?.rootViewController
//
//    }
}


private extension PlayerViewController {
    func setUpGestures() {
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpAction))
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap?.numberOfTapsRequired = 2
        
        swipeDown?.direction = .down
        swipeUp?.direction = .up
        swipeLeft?.direction = .left
        
        self.avPlayerController.view.addGestureRecognizer(swipeDown!)
        self.avPlayerController.view.addGestureRecognizer(swipeUp!)
        self.avPlayerController.view.addGestureRecognizer(swipeLeft!)
        self.avPlayerController.view.addGestureRecognizer(doubleTap!)
    }
    
    @objc func swipeDownAction() {
        print("swipe down")
        minimizePlayerWindow()
    }
    
    @objc func swipeUpAction() {
        print("swipe up")

//        restorePlayerWindow()
    }
    
    @objc func swipeLeftAction() {
        print("swipe left")

//        guard isMinimized, UIDevice.current.userInterfaceIdiom == .pad  else { return }
//        UIView.animate(withDuration: duration, animations: {
//            self.mpContainer.alpha = 0.0
//            self.mpContainer.transform = CGAffineTransform(translationX: -90, y: 0)
//        })
    }
    
    @objc func doubleTapped() {
        print("doubble tap")

//        guard isMinimized else { return }
//        restorePlayerWindow()
    }
    
    
    func minimizePlayerWindow() {
//        self.isMinimized = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let x: CGFloat = self.view.bounds.size.width - (ipadMiniPlayerWidth + margin)
            let y: CGFloat = self.view.bounds.size.height - (ipadMiniPlayerHeight + margin + 50)
            UIView.animate(withDuration: duration) {
                self.infoContainer.frame = CGRect(x: x, y: y, width: self.ipadMiniPlayerWidth, height: 0)
                self.playerContainer.frame = CGRect(x: x, y: y, width: self.ipadMiniPlayerWidth, height: self.ipadMiniPlayerHeight)
                self.avPlayerController.showsPlaybackControls = false
                self.view.frame = CGRect(x: x, y: y, width: self.ipadMiniPlayerWidth, height: self.ipadMiniPlayerHeight)

                self.infoContainer.alpha = 0.0
                self.view.layoutIfNeeded()
            }
        }
        
        
//        else {
//            let x: CGFloat = margin
//            let y: CGFloat = self.view.bounds.size.height - (iphoneMiniPlayerHeight + margin)
//
//            UIView.animate(withDuration: duration, animations: {
//                self.tallMpContainer.frame = CGRect(x: x, y: y, width: self.view.bounds.size.width - (2 * self.margin), height: 0)
//                self.mpContainer.frame = CGRect(x: x, y: y, width: self.view.bounds.size.width - (2 * self.margin), height: self.iphoneMiniPlayerHeight)
//                self.tallMpContainer.alpha = 0.0
//            }) { _ in
//                UIView.animate(withDuration: self.duration) {
//                    self.tinyPlayer.alpha = 1.0
//                    self.tinyPlayer.frame = CGRect(x: self.margin + self.iphoneMiniPlayerWidth, y: y, width: self.tinyPlayerWidth!, height: self.iphoneMiniPlayerHeight)
//                    self.mpContainer.frame = CGRect(x: x, y: y, width: self.iphoneMiniPlayerWidth, height: self.iphoneMiniPlayerHeight)
//                }
//            }
//        }
    }
    
}
