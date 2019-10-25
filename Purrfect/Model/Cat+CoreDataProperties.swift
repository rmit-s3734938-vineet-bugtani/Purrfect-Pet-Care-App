//
//  Cat+CoreDataProperties.swift
//  tableview
//
//  Created by Vineet Bugtani on 26/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//
//

import Foundation
import CoreData


extension Cat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cat> {
        return NSFetchRequest<Cat>(entityName: "Cat")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthDay: NSDate?
    @NSManaged public var catDescription: String?
    @NSManaged public var imageName: String?
    @NSManaged public var gender: String?
    @NSManaged public var breed: String?
    @NSManaged public var owner: Owner?

}
