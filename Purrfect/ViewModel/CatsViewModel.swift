

import Foundation

import UIKit

var sharedCatsViewModel = CatsViewModel()

class CatsViewModel{
    
    private (set) var cats : [Cat] = []
    private let formatter = DateFormatter()
    
    func getListt() -> [Cat]{
        return cats
    }
    
    init(){
        cats = catsManager.getList()
        formatter.dateFormat = "yyyy/MM/dd"
     
    }
    
    func refresh(){
        cats = catsManager.getList()
    }
    
   public  func removeData(index : Int) {

        cats.remove(at: index)

    }

   public func getGenderArray() -> [String] {
        var genderArray: [String] = []
    
        for gender in Gender.allCases{
            genderArray.append(gender.rawValue)
        }
    
        return genderArray
    }
    
    
    public func getBreedArray() -> [String] {
        var breedArray: [String] = []
        
        for breed in Breed.allCases{
            breedArray.append(breed.rawValue)
        }
        
        return breedArray
    }
    
    
    func getCat(index : Int) -> (name : String,birthDay : String,description : String,imageName : String,gender : String,breed : String){

        let name = cats[index].name
        let description = cats[index].catDescription
        let imageName = cats[index].imageName
        let gender = cats[index].gender
        let breed = cats[index].breed
        let birthDay = formatter.string(from: cats[index].birthDay! as Date)
        
        if let imageName = imageName{
             return(name!,birthDay,description!,imageName,gender!,breed!)
        }else{
             return(name!,birthDay,description!,"",gender!,breed!)
        }
       
    }
    
    private var catsManager = CatsManager.shared
    
    func getModel() -> CatsManager{
     return catsManager
    }
    
     func addData(ownerName : String,nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String){
        
        catsManager.addData(ownerName : ownerName,nameParam: nameParam, genderParam: genderParam , birthdayParam: birthdayParam, breedParam : breedParam, descParam : descParam)
        
    }
    
    func delete(index:Int){
        catsManager.deleteCat(index: index)
    }
    
    func editCats(index : Int,nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String){
        
      catsManager.editCats(index: index, nameParam: nameParam, genderParam: genderParam, birthdayParam: birthdayParam, breedParam: breedParam, descParam: descParam)
    }
    
}
