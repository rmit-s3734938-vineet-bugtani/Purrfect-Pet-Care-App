//
//  TabBarController.swift
//  tableview
//
//  Created by Vineet Bugtani on 25/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let firstTab = MainCoordinator(navigationController: UINavigationController())
    let secondTab = MainCoordinator(navigationController: UINavigationController())
    let thirdTab = MainCoordinator(navigationController: UINavigationController())
    let fourthTab = MainCoordinator(navigationController: UINavigationController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTab.startFirstTab()
        secondTab.createMasterView()
        thirdTab.createBreedViewController()
        fourthTab.createFaceRecognitionViewController()
       
        
        viewControllers = [firstTab.navigationController,secondTab.navigationController,thirdTab.navigationController,fourthTab.navigationController]
    }
    
    
    
}
