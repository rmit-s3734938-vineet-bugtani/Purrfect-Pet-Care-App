//
//  Cat+CoreDataClass.swift
//  tableview
//
//  Created by Vineet Bugtani on 26/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//
//

import Foundation
import CoreData

enum Gender:String,CaseIterable{
    case male="Male", female="Female"
}

enum Breed: String,CaseIterable{
    case  persian="Persian", ragdoll="Ragdoll", munchkin="Munchkin", siberian="Siberian",maineCoon="Maine Coon"
}

@objc(Cat)
public class Cat: NSManagedObject {

}
