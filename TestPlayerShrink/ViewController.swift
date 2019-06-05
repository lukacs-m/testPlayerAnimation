//
//  ViewController.swift
//  TestPlayerShrink
//
//  Created by Martin Lukacs on 03/06/2019.
//  Copyright © 2019 com.plop.plop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tallMpContainer: UIView!
    @IBOutlet weak var mpContainer: UIView!
    @IBOutlet weak var tinyPlayer: UIView!
    
    private var fullscreenmpContainer: CGRect?
    private var fullscreentallMpContainer: CGRect?
    private var tinyContainer: CGRect?
    private var swipeDown: UISwipeGestureRecognizer?
    private var swipeUp: UISwipeGestureRecognizer?
    private var swipeLeft: UISwipeGestureRecognizer?
    private var doubleTap: UITapGestureRecognizer?
    private var isMinimized = false
    
    private let ipadMiniPlayerHeight: CGFloat = 90.0
    private let ipadMiniPlayerWidth: CGFloat = 160.0
    private let iphoneMiniPlayerHeight: CGFloat = 72.0
    private let iphoneMiniPlayerWidth: CGFloat = 128.0
    private let duration: TimeInterval = 0.5
    private let margin: CGFloat = 5.0
    private var tinyPlayerWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        tinyPlayerWidth = view.bounds.size.width - margin - iphoneMiniPlayerWidth
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fullscreenmpContainer = mpContainer.frame
        fullscreentallMpContainer = tallMpContainer.frame
        tinyContainer = tinyPlayer.frame
    }
    
    @objc func swipeDownAction() {
        minimizePlayerWindow()
    }
    
    @objc func swipeUpAction() {
        restorePlayerWindow()
    }
    
    @objc func swipeLeftAction() {
        guard isMinimized, UIDevice.current.userInterfaceIdiom == .pad  else { return }
        UIView.animate(withDuration: duration, animations: {
            self.mpContainer.alpha = 0.0
            self.mpContainer.transform = CGAffineTransform(translationX: -90, y: 0)
        })
    }
    
    @objc func doubleTapped() {
        guard isMinimized else { return }
        restorePlayerWindow()
    }
    
    func minimizePlayerWindow() {
        self.isMinimized = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let x: CGFloat = self.view.bounds.size.width - (ipadMiniPlayerWidth + margin)
            let y: CGFloat = self.view.bounds.size.height - (ipadMiniPlayerHeight + margin)
            UIView.animate(withDuration: duration) {
                self.tallMpContainer.frame = CGRect(x: x, y: y, width: self.ipadMiniPlayerWidth, height: 0)
                self.mpContainer.frame = CGRect(x: x, y: y, width: self.ipadMiniPlayerWidth, height: self.ipadMiniPlayerHeight)
                self.tallMpContainer.alpha = 0.0
            }
        } else {
            let x: CGFloat = margin
            let y: CGFloat = self.view.bounds.size.height - (iphoneMiniPlayerHeight + margin)
            
            UIView.animate(withDuration: duration, animations: {
                self.tallMpContainer.frame = CGRect(x: x, y: y, width: self.view.bounds.size.width - (2 * self.margin), height: 0)
                self.mpContainer.frame = CGRect(x: x, y: y, width: self.view.bounds.size.width - (2 * self.margin), height: self.iphoneMiniPlayerHeight)
                self.tallMpContainer.alpha = 0.0
            }) { _ in
                UIView.animate(withDuration: self.duration) {
                    self.tinyPlayer.alpha = 1.0
                    self.tinyPlayer.frame = CGRect(x: self.margin + self.iphoneMiniPlayerWidth, y: y, width: self.tinyPlayerWidth!, height: self.iphoneMiniPlayerHeight)
                    self.mpContainer.frame = CGRect(x: x, y: y, width: self.iphoneMiniPlayerWidth, height: self.iphoneMiniPlayerHeight)
                }
            }
        }
    }
    
    func restorePlayerWindow() {
        self.isMinimized = false
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.animate(withDuration: duration) {
                self.tallMpContainer.frame = self.fullscreentallMpContainer!
                self.mpContainer.frame = self.fullscreenmpContainer!
                self.tallMpContainer.alpha = 1.0
            }
        } else {
            let x: CGFloat = margin
            let y: CGFloat = self.view.bounds.size.height - (iphoneMiniPlayerHeight + margin)
            UIView.animate(withDuration: duration, animations: {
                self.tinyPlayer.alpha = 0.0
                self.tinyPlayer.frame = self.tinyContainer!
                self.mpContainer.frame = CGRect(x: x, y: y, width: self.view.bounds.size.width - (2 * self.margin), height: self.iphoneMiniPlayerHeight)
            }) { _ in
                UIView.animate(withDuration: self.duration) {
                    self.tallMpContainer.alpha = 1.0
                    self.tallMpContainer.frame = self.fullscreentallMpContainer!
                    self.mpContainer.frame = self.fullscreenmpContainer!
                }
            }
        }
    }
    
    func minimizeIpadWindow(minimized: Bool, animated: Bool) {
        //        if isMinimized() == minimized {
        //            return
        //        }
        
        var tallContainerFrame: CGRect
        var containerFrame: CGRect
        var tallContainerAlpha: CGFloat
        
        if minimized == true {
            
            let mpWidth: CGFloat = 160
            let mpHeight: CGFloat = 90
            
            let x: CGFloat = self.view.bounds.size.width - (mpWidth + 25)
            let y: CGFloat = self.view.bounds.size.height - (mpHeight + 25)
            
            tallContainerFrame = CGRect(x: x, y: y, width: mpWidth, height: 0)
            containerFrame = CGRect(x: x, y: y, width: mpWidth, height: mpHeight)
            tallContainerAlpha = 0.0
            
        } else {
            tallContainerFrame = fullscreentallMpContainer!
            containerFrame = fullscreenmpContainer!
            tallContainerAlpha = 1.0
        }
        
        let duration: TimeInterval = (animated) ? 0.5 : 0.0
        UIView.animate(withDuration: duration) {
            self.isMinimized = !self.isMinimized
            self.tallMpContainer.frame = tallContainerFrame
            self.mpContainer.frame = containerFrame
            self.tallMpContainer.alpha = tallContainerAlpha
        }
    }
    
    func minimizeIphoneWindow(minimized: Bool, animated: Bool) {
        
        var tallContainerFrame: CGRect
        var containerFrame: CGRect
        var tallContainerAlpha: CGFloat
        
        if minimized == true {
            
            let mpWidth: CGFloat = 160
            let mpHeight: CGFloat = 90
            
            let x: CGFloat = self.view.bounds.size.width - (mpWidth)
            let y: CGFloat = self.view.bounds.size.height - (mpHeight + 25)
            
            tallContainerFrame = CGRect(x: x, y: y, width: mpWidth, height: 0)
            containerFrame = CGRect(x: x, y: y, width: mpWidth, height: mpHeight)
            tallContainerAlpha = 0.0
            
        } else {
            tallContainerFrame = fullscreentallMpContainer!
            containerFrame = fullscreenmpContainer!
            tallContainerAlpha = 1.0
        }
        
        if minimized == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.isMinimized = !self.isMinimized
                self.tallMpContainer.frame = tallContainerFrame
                self.mpContainer.frame = containerFrame
                self.tallMpContainer.alpha = tallContainerAlpha
            }) { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.tinyPlayer.alpha = 1.0
                    self.mpContainer.transform = CGAffineTransform(translationX: -(self.view.bounds.size.width - 160), y: 0)
                    self.tinyPlayer.frame = CGRect(x: 0 + containerFrame.size.width, y: self.view.bounds.size.height - (90 + 25), width: self.view.bounds.size.width - containerFrame.size.width, height: 90)
                    self.view.layoutIfNeeded()
                    
                })
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.tinyPlayer.alpha = 0.0
                self.mpContainer.transform = CGAffineTransform(translationX: self.view.bounds.size.width - 160, y: 0)
                self.tinyPlayer.frame = CGRect(x: 0 + containerFrame.size.width, y: self.view.bounds.size.height - (90 + 25), width: 1, height: 1)
            }) { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.isMinimized = !self.isMinimized
                    self.tallMpContainer.frame = tallContainerFrame
                    self.mpContainer.frame = containerFrame
                    self.tallMpContainer.alpha = tallContainerAlpha
                    self.view.layoutIfNeeded()
                })
            }
            
        }
    }
    
    
}


private extension ViewController {
    func setUpGestures() {
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpAction))
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap?.numberOfTapsRequired = 2
        
        swipeDown?.direction = .down
        swipeUp?.direction = .up
        swipeLeft?.direction = .left
        
        self.mpContainer.addGestureRecognizer(swipeDown!)
        self.mpContainer.addGestureRecognizer(swipeUp!)
        self.mpContainer.addGestureRecognizer(swipeLeft!)
        self.mpContainer.addGestureRecognizer(doubleTap!)
    }
}
