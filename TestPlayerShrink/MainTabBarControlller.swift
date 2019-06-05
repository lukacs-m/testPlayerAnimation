//
//  MainTabBarControlller.swift
//  TestPlayerShrink
//
//  Created by Martin Lukacs on 04/06/2019.
//  Copyright © 2019 com.plop.plop. All rights reserved.
//
import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
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

