//
//  MainTabBarControlller.swift
//  TestPlayerShrink
//
//  Created by Martin Lukacs on 04/06/2019.
//  Copyright © 2019 com.plop.plop. All rights reserved.
//
import UIKit
import SnapKit

protocol PlayerPresenter: class {
    func showPlayer()
//    func hidePlayer()
}

extension PlayerPresenter where Self: UIViewController {
    func showPlayer() {
        let playerVC = NewStackViewPlayerViewController(nibName: "NewStackViewPlayerViewController", bundle: nil)
        playerVC.view.frame = view.safeAreaLayoutGuide.layoutFrame
        playerVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerVC.view.alpha = 0
        playerVC.view.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        self.addChild(playerVC)
        self.view.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
    
        UIView.animate(withDuration: 0.5, animations: {
            playerVC.view.transform = .identity  //CGAffineTransform(translationX: 0, y: 0)
            playerVC.view.alpha = 1
//            playerVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//            playerVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//            playerVC.view.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
//            playerVC.view.bottomAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1).isActive = true

            
//            playerVC.view.frame = CGRect(x: 0, y: 40, width: UIApplication.shared.keyWindow!.bounds.width, height: UIApplication.shared.keyWindow!.bounds.height)
//
//            playerVC.view.snp.makeConstraints { make in
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
//                //Top guide
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
//                //Leading guide
//                make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leadingMargin)
//                //Trailing guide
//                make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailingMargin)
////                make.edges.equalToSuperview()
//            }
            
        })
    }
    
    func hideContentController() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        
//        content.willMove(toParent: nil)
//        content.view.removeFromSuperview()
//        content.removeFromParent()
    }
    

}



class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate, PlayerPresenter {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.actionTapOnScrollView(sender:)))
//        self.view.addGestureRecognizer(tapGesture)

        setUpUI()
    }
    
    /// Sets up the tabbar controller view and controllers
    private func setUpUI() {
        
        addController(FirstViewController(), name: "First", image: nil, selectedImage: nil)
        addController(SecondViewController(), name: "Second", image: nil, selectedImage: nil)

        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
    
    @objc private func actionTapOnScrollView(sender:UITapGestureRecognizer){
        print("user Touched")
    }
    
}

extension MainTabBarViewController {
    
    ///
    /// add controller to tabbar
    /// - parameter controller: controller to add
    /// - parameter name: name to display in tab bar
    /// - parameter image: image to display
    /// - parameter selectedImage: image to display when selected
    /// - parameter insideNavController: add controller inside navcontroller
    ///
    private func addController(_ controller: UIViewController, name: String, image: UIImage?, selectedImage: UIImage?, insideNavController: Bool = true) {
        var newController = controller
        
        // create navbar if needed
        if insideNavController {
            let nav = UINavigationController(rootViewController: controller)
            
            newController = nav
        }
        
        self.viewControllers == nil ? self.viewControllers = [newController] : self.viewControllers?.append(newController)
        
        //create tabar item
        newController.tabBarItem = UITabBarItem(
            title: name,
            image:  image?.withRenderingMode(.alwaysOriginal),
            selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal)
        )
        
        newController.tabBarItem.tag = self.viewControllers?.count ?? 0
    }
}

