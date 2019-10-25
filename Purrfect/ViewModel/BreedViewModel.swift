//
//  BreedViewModel.swift
//  tableview
//
//  Created by Caecario Wardana on 27/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import Foundation
import UIKit

struct BreedViewModel {
    
    private var model = REST_Request.shared
    
    
    var delegate: Refresh? {
        get{
            return model.delegate
        }
        
        set (value){
            model.delegate = value
        }
    }
    
    func getOrigin() -> String {
        return model.selectedBreedInfo.origin!
    }
    
    func getTemperament() -> String {
        return model.selectedBreedInfo.temperament!
    }
    
    func getLifeSpan() -> String {
        return model.selectedBreedInfo.lifeSpan!
    }
    
    func getDescription() -> String {
        return model.selectedBreedInfo.description!
    }
    
    func getImage() -> UIImage? {
        let url = model.selectedBreedInfo.imageURL
        let imageURL = URL(string: url!)
        let data = try? Data(contentsOf: imageURL!)
        let image: UIImage? = nil
        if let imageData = data {
            return UIImage(data: imageData)
        }
        
        return image
    }
    
    func getBreedArray() -> [(name: String, id: String)] {
        return model.selectedBreedInfo.breeds
    }
    
    func getBreedInformation(with breedID: String) {
        model.getBreedInformation(withBreedID: breedID)
    }
}
