//
//  NewStackViewPlayerViewController.swift
//  TestPlayerShrink
//
//  Created by Martin Lukacs on 07/06/2019.
//  Copyright © 2019 com.plop.plop. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class NewStackViewPlayerViewController: UIViewController {
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var playerViewContainer: UIView!
    @IBOutlet weak var bottomViewContainer: UIView!
    @IBOutlet weak var miniControlContainer: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    private var swipeUp: UISwipeGestureRecognizer?
    private var swipeLeft: UISwipeGestureRecognizer?
    private var doubleTap: UITapGestureRecognizer?
    
    private let iphoneMiniPlayerHeight: CGFloat = 72.0
    @IBOutlet weak var playerWidth: NSLayoutConstraint!
    
    @IBOutlet weak var minimizeButton: UIButton!
    private let margin: CGFloat = 5.0
    private let duration: TimeInterval = 0.5
    private var isMinimized = false
    
    var player: AVQueuePlayer!
    var avPlayerController: AVPlayerViewController!
    private var token: NSKeyValueObservation?
    var playerItems = [AVPlayerItem(url: URL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")!),
                       AVPlayerItem(url: URL(string: "https://sdn-global-streaming-cache.3qsdn.com/stream/9378/files/18/12/1067680/9378-yYhz8P4dXGDjxn6H.ism/manifest.m3u8?format=hls&mime=mp4&source=html5")!)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpPlayer()
        setUpGestures()
    }
    
    
    @IBAction func minimizeAction(_ sender: Any) {
        minimize()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
        player.play()
    }
    
    
}


private extension NewStackViewPlayerViewController {
    func minimize() {
        guard UIDevice.current.userInterfaceIdiom != .pad  else {
            return }

        
        self.isMinimized = true
        
        
        
    
        
        let y: CGFloat = self.view.frame.size.height - (72 + margin)
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [.calculationModeLinear], animations: {
            // Add animations
            
            UIView.addKeyframe(withRelativeStartTime: 0/4, relativeDuration: 1/4, animations: {
                self.view.frame = CGRect(x: self.margin, y: y, width: self.view.bounds.size.width - (2 * self.margin), height: 72)
                
                self.view.layoutIfNeeded()
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4, animations: {
                self.avPlayerController.showsPlaybackControls = false
                print(self.playerViewContainer.bounds)
                self.topViewContainer.isHidden = true
                self.topViewContainer.alpha = 0
                self.bottomViewContainer.alpha = 0
                self.miniControlContainer.isHidden = false

                self.bottomViewContainer.isHidden = true
                self.minimizeButton.isHidden = true
                self.mainStackView.layoutIfNeeded()
                self.view.layoutIfNeeded()

            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 2/4, animations: {
                self.mainStackView.axis = .horizontal
//                self.miniControlContainer.isHidden = false
                self.mainStackView.layoutIfNeeded()
                self.view.layoutIfNeeded()
                self.miniControlContainer.alpha = 1
            })
            
        }, completion:{ _ in

            print("I'm done!")
        })
    }
    
    func restorePlayerWindow() {
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2/5, animations: {
                self.mainStackView.axis = .vertical
                self.miniControlContainer.isHidden = true
                self.view.layoutIfNeeded()
            })
            
            // Add animations
            UIView.addKeyframe(withRelativeStartTime: 2/5, relativeDuration: 3/5, animations: {
                
                self.view.frame = CGRect(x: 0, y: 40, width: self.view.superview?.bounds.width ?? 45, height: self.view.superview?.bounds.height ?? 45)
                self.topViewContainer.isHidden = false
                self.bottomViewContainer.isHidden = false
                self.view.layoutIfNeeded()
                
            })
            
        }, completion:{ _ in
            self.minimizeButton.isHidden = false
            self.avPlayerController.showsPlaybackControls = true
            
            print("I'm done!")
        })
    }
}



private extension NewStackViewPlayerViewController {
    func setUpPlayer() {
        player = AVQueuePlayer(items: playerItems)
        avPlayerController = AVPlayerViewController()
        avPlayerController.player = player
        avPlayerController.allowsPictureInPicturePlayback = true
        avPlayerController.view.frame = self.playerViewContainer.bounds
        avPlayerController.updatesNowPlayingInfoCenter = false
        self.addChild(avPlayerController)
        self.playerViewContainer.addSubview(avPlayerController.view);
        
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
    }
    
    func setUpGestures() {
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpAction))
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap?.numberOfTapsRequired = 2
        
        swipeUp?.direction = .up
        swipeLeft?.direction = .left
        
        self.avPlayerController.view.addGestureRecognizer(swipeUp!)
        self.avPlayerController.view.addGestureRecognizer(swipeLeft!)
        self.avPlayerController.view.addGestureRecognizer(doubleTap!)
    }
    
    
    @objc func swipeUpAction() {
        print("swipe up")
        guard isMinimized else { return }
        restorePlayerWindow()
    }
    
    @objc func swipeLeftAction() {
        print("swipe left")
        
        //        guard isMinimized, UIDevice.current.userInterfaceIdiom == .pad  else { return }
        //        UIView.animate(withDuration: duration, animations: {
        //            self.playerContainer.alpha = 0.0
        //            self.playerContainer.transform = CGAffineTransform(translationX: -90, y: 0)
        //        })
    }
    
    @objc func doubleTapped() {
        print("doubble tap")
        
        guard isMinimized else { return }
        restorePlayerWindow()
    }
}
