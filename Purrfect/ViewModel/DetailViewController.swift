
import UIKit

class DetailViewController: UIViewController,ChangeDataDelegate,Storyboarded {
    
    var myViewModel : CatsViewModel?
    var index : Int = 0
   
    
    @IBOutlet weak var birthDay: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var catsDescription: UITextView!
   
    weak var coordinator : MainCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleImage()
        styleDescriptionBox()
        prefillData()
        setNavBar()
    }
    
    private func setNavBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(navigateToNextView))
    }
    
    private func styleImage(){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        let brightRed = UIColor(red: 0.94, green: 0.47, blue: 0.62, alpha: 1.0)
        image.layer.borderColor = brightRed.cgColor
    }
    
    private func styleDescriptionBox(){
        catsDescription.clipsToBounds = false
        catsDescription.layer.shadowOpacity=0.1
        catsDescription.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func prefillData(){
        name.text = myViewModel!.getCat(index: index).name
        birthDay.text = myViewModel!.getCat(index: index).birthDay
        gender.text = myViewModel!.getCat(index: index).gender
        breed.text = myViewModel!.getCat(index: index).breed
        //image.image = UIImage(named: myViewModel!.getCat(index: index).imageName)
        catsDescription.text = myViewModel!.getCat(index: index).description
    }
    
   
    func userEnteredNewData(nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String) {
        name.text = nameParam
        gender.text = genderParam
        birthDay.text = birthdayParam
        breed.text = breedParam
        catsDescription.text = descParam

    }
    
    @objc func navigateToNextView(){
        coordinator?.createEditView(index: index, myViewModel: myViewModel! , delegate : self)
    }
   

}
