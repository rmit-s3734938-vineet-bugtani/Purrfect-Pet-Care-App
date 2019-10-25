//
//  BreedViewController.swift
//  tableview
//
//  Created by Caecario Wardana on 27/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import UIKit

class BreedViewController: UIViewController, Refresh,Storyboarded {
    
    weak var coordinator : MainCoordinator?
    
    @IBOutlet weak var selectBreedTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var viewModel = BreedViewModel()
    private var selectedBreed: String?
    private var selectedID: String?
    var vSpinner : UIView?
    
    func updateUI() {
        self.removeSpinner()
        imageView.image = viewModel.getImage()
        originLabel.text = "Origin: \(viewModel.getOrigin())"
        temperamentLabel.text = "Temperament: \(viewModel.getTemperament())"
        lifeSpanLabel.text = "Lifespan: \(viewModel.getLifeSpan()) years"
        descriptionTextView.text = viewModel.getDescription()
    }
    
    
    private func createPickerView() {
        // Creating a new UIPickerView object
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        selectBreedTextField.inputView = pickerView
        
        pickerView.backgroundColor = .white
        
    }
    
    private func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BreedViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        selectBreedTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test REST request
        self.showSpinner(onView: self.view)
        REST_Request.shared.getBreedInformation(withBreedID:"abys")
       
        viewModel.delegate = self
        
        createPickerView()
        createToolbar()
        
        let pink = UIColor(red: 0.94, green: 0.47, blue: 0.62, alpha: 1.0)
       // let purple = UIColor(red: 0.84, green: 0.70, blue: 0.97, alpha: 1.0)
        
       // imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        //imageView.layer.borderColor = purple.cgColor
        
        selectBreedTextField.layer.borderWidth = 1.0
        selectBreedTextField.layer.borderColor = pink.cgColor
        
        self.navigationController?.navigationBar.isHidden = true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BreedViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return viewModel.getBreedArray().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return viewModel.getBreedArray()[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBreed = viewModel.getBreedArray()[row].name
        selectedID = viewModel.getBreedArray()[row].id
        selectBreedTextField.text = selectedBreed
        
        viewModel.getBreedInformation(with: selectedID!)
        
    }
    
}

extension BreedViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
