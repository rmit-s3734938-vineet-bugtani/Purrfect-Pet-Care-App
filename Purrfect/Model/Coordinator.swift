//
//  Coordinator.swift
//  tableview
//
//  Created by Vineet Bugtani on 25/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import UIKit

protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
}
