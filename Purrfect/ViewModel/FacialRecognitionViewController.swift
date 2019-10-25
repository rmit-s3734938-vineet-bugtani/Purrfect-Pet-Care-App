//
//  FacialRecognitionViewcontroller.swift
//  tableview
//
//  Created by Qi Sun on 12/10/2019.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FacialRecognitionViewController: UIViewController,Storyboarded {
    weak var coordinator : MainCoordinator?
    var app_id = "d49fc39a"
    var app_key = "a5bb9e3cd07d202b829e4ba703ab62a5"
    
    let imagePicker = UIImagePickerController()
    var receivedGalleryName = ""
    var isEnrol = false
    
    
    @IBOutlet weak var idEnrollTextField: UITextField!
    @IBOutlet weak var galleryEnrollTextField: UITextField!
    @IBOutlet weak var facialRecgnitionTextField: UITextField!
    @IBAction func enrolButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.hideKeyboardWhenTappedAround()
        //loadingLabel.alpha = 0
    }
    
    func enroll(imageBase64:String) {
        var request = URLRequest(url: URL(string: "https://api.kairos.com/enroll")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(app_id, forHTTPHeaderField: "app_id")
        request.setValue(app_key, forHTTPHeaderField: "app_key")
        
        // Passing the parameters
        let params : NSMutableDictionary? = [
            "image" : imageBase64,
            "gallery_name" : galleryEnrollTextField.text!,
            "subject_id" : idEnrollTextField.text!
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        
        print("Sending enrolment request...")
        
        Alamofire.request(request).responseJSON{
            (response) in
            if((response.result.value) != nil){
                //
                
                print("Getting recognition response...")
                let json = JSON(response.result.value!)
                //
                let alert = UIAlertController(title: "kairosFacial", message: "\(json)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
              //  self.loadingLabel.alpha = 0
            }
        }
    }
    
    @IBAction func choosePhoteAndEnroll(_ sender: Any) {
        if(galleryEnrollTextField.text != "" && idEnrollTextField.text != ""){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            
            isEnrol = true
        }else{
            let alert = UIAlertController(title: "Kairos", message: "Please enter all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func recognize(_ sender: Any) {
        // let storyBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        //let cameraController = storyBoard.instantiateViewController(withIdentifier: "camera_view")
        // as! CameraViewController
        //cameraController.receivedGalleryName = facialRecognitionTextfield.text!
        // self.present(cameraController, animated: true, completion: nil)
        if facialRecgnitionTextField.text != "" {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            
            isEnrol = false
        }else{
            let alert = UIAlertController(title: "Kairos", message: "Please enter all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func recognize(imageBase64: String) {
        var request = URLRequest(url: URL(string: "https://api.kairos.com/recognize")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(app_id, forHTTPHeaderField: "app_id")
        request.setValue(app_key, forHTTPHeaderField: "app_key")
        
        let params : NSMutableDictionary? = [
            "image" : imageBase64,
            "gallery_name" : facialRecgnitionTextField.text!,
            ]
        
        let data = try! JSONSerialization.data(withJSONObject: params!, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        
        print("Sending recognition request...")
        
        Alamofire.request(request).responseJSON { (response) in
            if((response.result.value) != nil) {
                
                print("Getting recognition response...")
                let json = JSON(response.result.value!)
                
                
                
                
                let alert = UIAlertController(title: "kairosFacial", message: "\(json)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
              //  self.loadingLabel.alpha = 0
            }
        }
    }
}

extension FacialRecognitionViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // Gets the picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // different
        if isEnrol == true {
          //  loadingLabel.text = "Enroling facial data to our servers, please wait..."
          //  loadingLabel.alpha = 1
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                
                print("Enroling image to database")
                // Convert to Jpeg as Kairos does not work with png
                let imagedata = pickedImage.jpegData(compressionQuality: 0.2)
                let base64String:String = imagedata!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                let imagestr :String = base64String.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                // Enrols the photo when the image is picked
                enroll(imageBase64: imagestr)
            }
        } else if isEnrol == false {
           // loadingLabel.text = "Analyzing facial data, please wait..."
           // loadingLabel.alpha = 1
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                print("Analyzing image...")
                
                // Convert to Jpeg as Kairos does not work with png
                let imagedata = pickedImage.jpegData(compressionQuality: 0.2)
                let base64String:String = imagedata!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                let imagestr :String = base64String.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                // Enrols the photo when the image is picked
                recognize(imageBase64: imagestr)
            }
            
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController{
    func hideKeyboardWhenTappedAround(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismisskeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismisskeyboard(){
        view.endEditing(true)
    }
}
