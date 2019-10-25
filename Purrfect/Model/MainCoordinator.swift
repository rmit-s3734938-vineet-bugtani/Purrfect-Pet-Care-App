//
//  MainCoordinator.swift
//  tableview
//
//  Created by Vineet Bugtani on 25/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//


import UIKit

class MainCoordinator: NSObject,Coordinator,UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startFirstTab() {
        navigationController.delegate = self
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        let tabitem = UITabBarItem()
        tabitem.title = "Owner"
        tabitem.image = UIImage(named: "icons8-top-menu-30")
        vc.tabBarItem = tabitem
        navigationController.pushViewController(vc, animated: false)
    }

    func createMasterView(){
        navigationController.delegate = self
        let vcNext = YourCatsViewController.instantiate()
        vcNext.coordinator = self
        let tabitem = UITabBarItem()
        tabitem.title = "Cats"
        tabitem.image = UIImage(named: "icons8-cat-profile-30")
        vcNext.tabBarItem = tabitem
        navigationController.pushViewController(vcNext, animated: false)

    }

    
    func createDetailView(index : Int ,myViewModel : CatsViewModel){
        let vc = DetailViewController.instantiate()
        vc.coordinator = self
        vc.index = index
        vc.myViewModel = myViewModel
        navigationController.pushViewController(vc, animated: false)
        
    }
    
    func createEditView(index : Int ,myViewModel : CatsViewModel , delegate : DetailViewController){
        let vc = AddCatViewController.instantiate()
        vc.coordinator = self
        vc.currentCatIndex = index
        vc.myViewModel = myViewModel
        vc.seagueIdentifier = "y"
        vc.delegate = delegate
        navigationController.pushViewController(vc, animated: false)
        
    }
    
    func createAddView(myViewModel : CatsViewModel){
        let vc = AddCatViewController.instantiate()
        vc.coordinator = self
        vc.myViewModel = myViewModel
        vc.seagueIdentifier = "goToAddCats"
        navigationController.pushViewController(vc, animated: false)
        
    }
    
    func createBreedViewController(){
        let vc = BreedViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        
    }
    
    func createFaceRecognitionViewController(){
        let vc = FacialRecognitionViewController.instantiate()
        vc.coordinator = self
        let tabitem = UITabBarItem()
        tabitem.title = "Face Recognition"
        tabitem.image = UIImage(named: "icons8-cat-profile-30")
        vc.tabBarItem = tabitem
        navigationController.pushViewController(vc, animated: false)
    }
    
}

