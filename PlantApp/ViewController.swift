//
//  ViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 01/04/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailIdText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    var isPasswordVisible = false
    
    let users:[String: String] = ["nagarjuna@gmail.com": "Welcome@1", "nag@gmail.com": "Nag@12311", "nag123@gmail.com": "Welcome123"]
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
       
    }

    @IBAction func visibiltyPassword(sender: UIButton){
       isPasswordVisible.toggle()
        passwordText.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye.fill" : "eye.slash.fill"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailIdText.text, let password = passwordText.text else {
            return
        }
        if email.isEmpty || password.isEmpty {
            showAlert("Email id or password is empty")
        }else if let storedPassword = users[email], storedPassword == password {
            errorLabel.isHidden = true
            print("Login successfull")
        }else {
            
            showAlert("Invalid email id or password")
            
            }
    }
    
    func showAlert(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}

