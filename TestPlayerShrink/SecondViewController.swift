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
        print("WOOOT 1")
    }

}
