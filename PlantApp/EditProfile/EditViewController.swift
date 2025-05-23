//
//  EditViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 21/05/25.
//

import UIKit
import IQKeyboardManagerSwift

class EditViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTextLabelAlert: UILabel!
    //@IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneTextLabelAlret: UILabel!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var bloodGroupTextField: UITextField!
    
    let genderPickerView = UIPickerView()
    let bloodGroupPickerView = UIPickerView()
    
    weak var delegate: EditViewControllerDelegate?
    
    let gender = ["Male", "Female","Other"]
    let bloodGroup = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
     
    let datePicker = UIDatePicker()
    
    let editViewModel = EditViewModel()
    var selectedProfileDetails: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        imageView?.layer.cornerRadius = 75
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        bloodGroupPickerView.delegate = self
        bloodGroupPickerView.dataSource = self
        
        dateTextField?.delegate = self
        genderTextField.inputView = genderPickerView
        userNameTextField.isUserInteractionEnabled = false
        emailTextField.delegate = self
        phoneTextField.delegate = self
        phoneTextLabelAlret.isEnabled = false
        emailTextLabelAlert.isEnabled = false
        phoneTextField.keyboardType = .numberPad
        IQKeyboardManager.shared.isEnabled = true           // Enable globally
        IQKeyboardManager.shared.enableAutoToolbar = true // Show toolbar with "Next", "Previous", "Done"
        IQKeyboardManager.shared.resignOnTouchOutside = true // Dismiss on background tap
        
        bloodGroupTextField.inputView = bloodGroupPickerView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveProfile))
    }
    func configureData(){
        nameTextField.text = "\(selectedProfileDetails?.firstName ?? "") \(selectedProfileDetails?.lastName ?? "")"
        userNameTextField.text = selectedProfileDetails?.username
        emailTextField.text = selectedProfileDetails?.email
        ageTextField.text = "\(selectedProfileDetails?.age ?? 0)"
       phoneTextField.text = selectedProfileDetails?.phone
       genderTextField.text = selectedProfileDetails?.gender
        dateTextField.text = selectedProfileDetails?.birthDate
        bloodGroupTextField.text = selectedProfileDetails?.bloodGroup
        if let urlString = selectedProfileDetails?.image{
            ApiServices.shared.loadImage(from: urlString) { image in
                self.imageView?.image = image
            }
        }
        
    }
    @IBAction func uplaodImageButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        //vc.sourceType = .camera
        vc.delegate = self
        let alretController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alretController.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            vc.sourceType = .camera
            self.present(vc,animated: true,completion: nil)
        }))
        alretController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            vc.sourceType = .photoLibrary
            self.present(vc,animated: true,completion: nil)
        }))
        alretController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alretController, animated: true)
        
    }
   
    func highLighttextField(_ textField: UITextField,isValid: Bool){
        textField.layer.borderWidth = isValid ? 0 : 1
        textField.layer.borderColor = isValid ? UIColor.black.cgColor : UIColor.red.cgColor
    }
    @objc func saveProfile(){
        guard var user = selectedProfileDetails else{ return }
        let fullName = nameTextField.text?.split(separator: " ") ?? []
        user.firstName = fullName.first.map(String.init)
        user.lastName = fullName.dropFirst().joined(separator: " ")
        user.age = Int(ageTextField.text ?? "0")
        user.email = emailTextField.text
        user.phone = phoneTextField.text
        user.birthDate = dateTextField.text
        user.gender = genderTextField.text
        user.bloodGroup = bloodGroupTextField.text
       // user.image = imageView?.image
        delegate?.didUpdateProfile(user)
        navigationController?.popViewController(animated: true)
    }

}
// for image uplaod
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            imageView?.image = editedImage
        }
        picker.dismiss(animated: true,completion: nil)
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
//gender picker view
extension EditViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == bloodGroupPickerView{
            return bloodGroup.count
        }
        else if pickerView == genderPickerView{
            return gender.count
        }
      return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == bloodGroupPickerView{
            return bloodGroup[row]
        }else if pickerView == genderPickerView{
            return gender[row]
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bloodGroupPickerView{
            bloodGroupTextField.text = bloodGroup[row]
            //bloodGroupTextField.resignFirstResponder()
        }
        else if pickerView == genderPickerView{
            genderTextField.text = gender[row]
            //genderTextField.resignFirstResponder()
        }
    }
}

//date picker

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTextField {
            
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.setItems([UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))], animated: true)
            textField.inputAccessoryView = toolbar
            textField.inputView = datePicker
            return true
        }
        return true
    }
    @objc func doneTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = datePicker.date
        dateTextField.text = formatter.string(from: datePicker.date)
        let age = editViewModel.calculateAge(from: selectedDate)
        ageTextField.text = "\(age)"
        dateTextField.resignFirstResponder()
    }
    // email and phone number validation
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            onEmailEditingEnded()
        }
        if textField == phoneTextField {
            onPhoneNumberEditing()
        }
    }
    func onEmailEditingEnded() {
        guard let email = emailTextField.text else { return }
        if !editViewModel.isValidateEmail(email){
            emailTextLabelAlert.isEnabled = true
            emailTextLabelAlert.text = "Invalid email format"
            highLighttextField(emailTextField, isValid: false)
        }else{
            highLighttextField(emailTextField, isValid: true)
            emailTextLabelAlert.text = ""
            emailTextLabelAlert.isEnabled = false
        }
        
    }
    func onPhoneNumberEditing() {
        guard let phone = phoneTextField.text else { return }
        if !editViewModel.isValidatePhoneNumber(phone){
            phoneTextLabelAlret.text! = "Phone number should be 10 digits"
            phoneTextLabelAlret.isEnabled = true
            highLighttextField(phoneTextField, isValid: false)
        }else{
            highLighttextField(phoneTextField, isValid: true)
            phoneTextLabelAlret.text = ""
            phoneTextLabelAlret.isEnabled = false
        }
    }
}

protocol EditViewControllerDelegate: AnyObject {
    func didUpdateProfile(_ userProfile: UserModel)
}

