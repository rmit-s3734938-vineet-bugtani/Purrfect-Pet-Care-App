//
//  Owner+CoreDataProperties.swift
//  tableview
//
//  Created by Vineet Bugtani on 26/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//
//

import Foundation
import CoreData


extension Owner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: "Owner")
    }

    @NSManaged public var name: String?
    @NSManaged public var ownerDescription: String?
    @NSManaged public var imageName: String?
    @NSManaged public var cats: NSSet?

}

// MARK: Generated accessors for cats
extension Owner {

    @objc(addCatsObject:)
    @NSManaged public func addToCats(_ value: Cat)

    @objc(removeCatsObject:)
    @NSManaged public func removeFromCats(_ value: Cat)

    @objc(addCats:)
    @NSManaged public func addToCats(_ values: NSSet)

    @objc(removeCats:)
    @NSManaged public func removeFromCats(_ values: NSSet)

}
