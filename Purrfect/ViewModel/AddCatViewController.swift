
import UIKit

//in
protocol ChangeDataDelegate {
    func userEnteredNewData(nameParam: String, genderParam: String , birthdayParam: String, breedParam : String, descParam : String)
}


class AddCatViewController: UIViewController,Storyboarded {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var nameValue : String?
    var genderValue : String?
    var breedValue : String?
    var birthDayValue : String?
    var imageNameValue : String?
    var catsDescriptionValue : String?
    var name : String?

    var myViewModel : CatsViewModel?
    var seagueIdentifier : String?
    var coordinator : MainCoordinator?
    var delegate : ChangeDataDelegate?
    
    private let notificationPublisher = NotificationPublisher()
    var currentCatIndex : Int = 0
    
    @IBAction func doneButton(_ sender: Any) {
        
        if nameTextField.text == "" || genderTextField.text == "" || breedTextField.text == "" || birthdayTextField.text == "" || descTextView.text == "" {
            let alert = UIAlertController(title: "Oops, you forgot something...", message: "It's recommended you fill in all the blanks before continuing.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            if seagueIdentifier == "goToAddCats"{
                myViewModel!.addData(ownerName: "abc", nameParam: nameTextField.text!, genderParam: genderTextField.text! , birthdayParam: birthdayTextField.text!, breedParam : breedTextField.text!, descParam : descTextView.text!)
                self.navigationController!.popViewController(animated: false)
            }
            else{
                myViewModel!.editCats(index : currentCatIndex, nameParam: nameTextField.text!, genderParam: genderTextField.text! , birthdayParam: birthdayTextField.text!, breedParam : breedTextField.text!, descParam : descTextView.text!)
                delegate?.userEnteredNewData(nameParam: nameTextField.text!, genderParam: genderTextField.text! , birthdayParam: birthdayTextField.text!, breedParam : breedTextField.text!, descParam : descTextView.text!)
                self.navigationController!.popViewController(animated: false)
                
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTheTable"), object: nil)
    }
    
    func editTextFieldEditSettings(){
         nameTextField.clearsOnBeginEditing = false
         genderTextField.clearsOnBeginEditing = false
         breedTextField.clearsOnBeginEditing = false
         birthdayTextField.clearsOnBeginEditing = false
        
    }

    // Button to select image from Camera or Photo Library
    // Sets imageView to user selected photo
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.modalPresentationStyle = .overCurrentContext
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    var selectedGender: String?
    var selectedBreed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerView()
        createToolbar()
        createDatePicker()
        editTextFieldEditSettings()
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
        
        imageView.layer.borderWidth = 3
        let brightRed = UIColor(red: 0.94, green: 0.47, blue: 0.62, alpha: 1.0)
        imageView.layer.borderColor = brightRed.cgColor
        
        let purple = UIColor(red: 0.84, green: 0.70, blue: 0.97, alpha: 1.0)
    
        nameTextField.layer.borderWidth = 1.0
        genderTextField.layer.borderWidth = 1.0
        birthdayTextField.layer.borderWidth = 1.0
        breedTextField.layer.borderWidth = 1.0
        
        
        nameTextField.layer.borderColor = purple.cgColor
        genderTextField.layer.borderColor = purple.cgColor
        birthdayTextField.layer.borderColor = purple.cgColor
        breedTextField.layer.borderColor = purple.cgColor
        
        
        
        if let seagueIdentifier = seagueIdentifier{
            if seagueIdentifier == "y"{
                populateTextFields()
             }
        }
    }
    

    func populateTextFields(){
        
        nameTextField.text = myViewModel!.getCat(index: currentCatIndex).name
        birthdayTextField.text = myViewModel!.getCat(index: currentCatIndex).birthDay
        genderTextField.text = myViewModel!.getCat(index: currentCatIndex).gender
        breedTextField.text = myViewModel!.getCat(index: currentCatIndex).breed
        descTextView.text = myViewModel!.getCat(index: currentCatIndex).description
    }
    
    // function to create the Picker View for gender and breed
    func createPickerView() {
        // Creating a new UIPickerView object
        let genderPickerView = UIPickerView()
        let breedPickerView = UIPickerView()
        
        genderPickerView.delegate = self
        breedPickerView.delegate = self
        
        genderTextField.inputView = genderPickerView
        breedTextField.inputView = breedPickerView
        
        //Customization
        genderPickerView.backgroundColor = .white
        breedPickerView.backgroundColor = .white
    }
    
    // function to create the DatePicker for birth date and alarm
    func createDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        
        // For birth date
        birthdayTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(AddCatViewController.dateChanged(datePicker:)), for: .valueChanged)

    }
    
    
    // These are methods to change the text in the TextField dynamically as the user changes the input using the UIPicker
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        birthdayTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    
    // function to create a toolbar that has the "Done" button to exit from keyboard
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddCatViewController.dissmissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        genderTextField.inputAccessoryView = toolBar
        breedTextField.inputAccessoryView = toolBar
        birthdayTextField.inputAccessoryView = toolBar

    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    
}

// Functions for UIPicker View
extension AddCatViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if genderTextField.isFirstResponder {
            return myViewModel!.getGenderArray().count
        } else if breedTextField.isFirstResponder {
            return myViewModel!.getBreedArray().count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if genderTextField.isFirstResponder {
            return myViewModel!.getGenderArray()[row]
        } else if breedTextField.isFirstResponder {
            return myViewModel!.getBreedArray()[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if genderTextField.isFirstResponder {
            selectedGender = myViewModel!.getGenderArray()[row]
            genderTextField.text = selectedGender
        } else if breedTextField.isFirstResponder {
            selectedBreed = myViewModel!.getBreedArray()[row]
            breedTextField.text = selectedBreed
        }
        
    }
    
}

// Extension for Image Picker functions
extension AddCatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
      //  storeImageToDocumentDirectory(image: image, fileName: "image")
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to save profile image into document folder in the device
    func storeImageToDocumentDirectory (image: UIImage, fileName: String) -> URL {
        let imageData = imageView.image?.jpegData(compressionQuality: 0.8)
        
        let fileURL = self.fileURLInDocumentDirectory(fileName)
        do {
            try imageData?.write(to: fileURL)
            return fileURL
        } catch {
            return fileURL 
        }
    }
    
    var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    
    func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }
}

