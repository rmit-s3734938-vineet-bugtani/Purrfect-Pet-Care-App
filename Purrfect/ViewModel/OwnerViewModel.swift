
import Foundation

struct OwnerViewModel{

    let owner = Owners(name: "Nelly Niawati", description : "Single, but I don't feel that way cause I'm married to my job and have two cats to care for.",imageName : "nelly")
    
    func getOwnerInfo() -> (name : String,description : String,imageName : String){
        
        return(owner.name,owner.description,owner.imageName)
    }
}

