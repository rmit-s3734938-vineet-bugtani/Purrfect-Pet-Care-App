//
//  CatsManager.swift
//  tableview
//
//  Created by Vineet Bugtani on 26/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import UIKit
import CoreData

class CatsManager{
    
    static let shared = CatsManager()
    
  //  let appDelegate : AppDelegate
    
    let managedContext : NSManagedObjectContext
    
    private (set) var cats : [Cat] = []
    
    let formatter = DateFormatter()
    
    func getList() -> [Cat]{
        return cats
    }
    
    let persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        managedContext = container.viewContext
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        formatter.dateFormat = "yyyy/MM/dd"
        loadCats()
    }
    
    private convenience init(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        self.init(container : appDelegate.persistentContainer)
        
    }
    
    private func createNSCat(owner : Owner,nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String) -> Cat{
        let catEntity = NSEntityDescription.entity(forEntityName: "Cat", in: managedContext)!
        
        let nsCat = NSManagedObject(entity: catEntity, insertInto: managedContext) as! Cat
        
        nsCat.setValue(nameParam, forKeyPath: "name")
        nsCat.birthDay = formatter.date(from: birthdayParam)! as NSDate
        nsCat.breed = breedParam
        nsCat.catDescription = descParam
        nsCat.gender = genderParam
        nsCat.owner = owner
        return nsCat
    }
    
    private func createNSOwner(ownerName : String) -> Owner{
        let ownerEntity = NSEntityDescription.entity(forEntityName: "Owner", in: managedContext)!
        
        let nsOwner = NSManagedObject(entity: ownerEntity, insertInto: managedContext) as! Owner
        
        nsOwner.setValue(ownerName, forKeyPath: "name")
       
        return nsOwner
    }
    
    func addData(ownerName : String,nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String){
        
        let nsOwner = createNSOwner(ownerName: ownerName)
        let nsCat = createNSCat(owner : nsOwner,nameParam: nameParam, genderParam: genderParam , birthdayParam: birthdayParam, breedParam : breedParam, descParam : descParam)
        cats.append(nsCat)
        
        do{
           try managedContext.save()
        }catch let error as NSError{
            print("could not save \(error)")
        }
    }
    
    private func loadCats(){
        do{
            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Cat")
            
            let result = try
                managedContext.fetch(fetchRequest)
            
            cats = result as! [Cat]
        }catch let error as NSError{
            print("could not save \(error)")
        }
       
        
    }
    
    
    func deleteCat(index:Int) {
        
        managedContext.delete(cats[index] as NSManagedObject)
        cats.remove(at: index)
        
        do {
            try managedContext.save()
            
        } catch {
            print("error : \(error)")
        }
    }
    
    func editCats(index : Int,nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String){
        
        let catToBeUpdated = cats[index] as NSManagedObject
        catToBeUpdated.setValue(nameParam, forKey: "name")
         catToBeUpdated.setValue(genderParam, forKey: "gender")
         catToBeUpdated.setValue(formatter.date(from: birthdayParam)! as NSDate, forKey: "birthDay")
         catToBeUpdated.setValue(breedParam, forKey: "breed")
         catToBeUpdated.setValue(descParam, forKey: "catDescription")
        do {
            try managedContext.save()
            
        } catch {
            print("error : \(error)")
        }
    }
    
}
