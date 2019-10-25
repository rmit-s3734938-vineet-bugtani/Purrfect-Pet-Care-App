//
//  PurrfectUnitTests.swift
//  PurrfectUnitTests
//
//  Created by Vineet Bugtani on 6/10/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import XCTest
import CoreData
@testable import Purrfect

class PurrfectUnitTests: XCTestCase {

    private var catsManager: CatsManager?
    private let formatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        formatter.dateFormat = "yyyy/MM/dd"
        catsManager = CatsManager(container: mockPersistantContainer)
        catsManager?.addData(ownerName: "Ryan", nameParam: "Snowbell", genderParam: "Male", birthdayParam: "2009/09/19", breedParam: "Persian", descParam: "Test cat")
        }
    
   func testAddingACat() {
        catsManager?.addData(ownerName: "Tracey", nameParam: "SnowWhite", genderParam: "Male", birthdayParam: "2009/09/19", breedParam: "Persian", descParam: "Test cat")
        XCTAssertEqual(2, catsManager?.cats.count)
    }
    
    func testDeletingACat() {
        catsManager?.deleteCat(index: 0)
        XCTAssertEqual(0, catsManager?.cats.count)
    }
    
    func testEditingACat(){
        catsManager?.editCats(index: 0, nameParam: "Cinderalla", genderParam: "Female", birthdayParam: "2019/09/19", breedParam: "Ragdoll", descParam: "This is my cat")
        XCTAssertEqual(catsManager?.cats[0].name, "Cinderalla")
        XCTAssertEqual(catsManager?.cats[0].gender, "Female")
        XCTAssertEqual(catsManager?.cats[0].breed, "Ragdoll")
        XCTAssertEqual(catsManager?.cats[0].catDescription, "This is my cat")
        XCTAssertEqual(catsManager?.cats[0].birthDay, formatter.date(from: "2019/09/19")! as NSDate)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DataModel", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

}
