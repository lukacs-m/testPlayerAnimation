//
//  SecondViewController.swift
//  TestPlayerShrink
//
//  Created by Martin Lukacs on 04/06/2019.
//  Copyright © 2019 com.plop.plop. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let movieLoadButton: UIButton = {
        let movieLoadButton = UIButton()
        movieLoadButton.setTitle("Load second movie", for: .normal)
        movieLoadButton.addTarget(self, action: #selector(movieLoad), for: .touchUpInside)
        return movieLoadButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        view.addSubview(movieLoadButton)
        movieLoadButton.translatesAutoresizingMaskIntoConstraints = false
        movieLoadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieLoadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    

    @objc func movieLoad() {
        guard let vc = UIApplication.shared.keyWindow?.rootViewController as? PlayerPresenter else { return }
        vc.showPlayer()
        
//        let playerVC = NewStackViewPlayerViewController(nibName: "NewStackViewPlayerViewController", bundle: nil)
//        //        playerVC.modalPresentationStyle = UIModalPresentationStyle.custom
//        //        playerVC.modalTransitionStyle = .
//        ////        playerVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
//        //        vc?.present(playerVC, animated: true)
//
//
//
//
//
//
//        //        let navigationController = UINavigationController(rootViewController: viewController)
//        //        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        //        self.present(navigationController, animated: false, completion: nil)
//        playerVC.view.frame = view.bounds
//        playerVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//
//        //        playerVC.view.frame = CGRect(x: view.frame.size.width, y: view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height)
//        playerVC.view.alpha = 0
//        playerVC.view.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
//        vc?.addChild(playerVC)
//
//        // Add child VC's view to parent
//        vc!.view.addSubview(playerVC.view)
//
//        // Register child VC
//        playerVC.didMove(toParent: vc!)
//        //
//
//
//        UIView.animate(withDuration: 0.5, animations: {
//            playerVC.view.transform =  .identity  //CGAffineTransform(translationX: 0, y: 0)
//            playerVC.view.alpha = 1
//
//            playerVC.view.frame = CGRect(x: 0, y: 40, width: UIApplication.shared.keyWindow!.bounds.width, height: UIApplication.shared.keyWindow!.bounds.height)
//
//        })
    }

}
