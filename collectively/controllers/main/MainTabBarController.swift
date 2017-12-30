//
//  MainTabBarController.swift
//  collectively
//
//  Created by Łukasz Bożek on 04/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func loadView() {
        super.loadView()
        setBarAppereance()
    }
    override func viewDidLoad() {
        setBarAppereance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setBarAppereance()
    }
    
    func setBarAppereance() {
        let tabBar = self.tabBar
        
        tabBar.tintColor = .themeBlue
    }
}
