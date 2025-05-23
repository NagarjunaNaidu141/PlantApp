//
//  CreateAccountViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 01/04/25.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var passwordVisibleButton: UIButton!
    @IBOutlet weak var confromPasswordVisibleButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    var isPasswordVisible: Bool = false
    var isPasswordVisible1: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
    }
    @IBAction func visibiltyPassword(sender: UIButton){
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye.fill" : "eye.slash.fill"
        passwordVisibleButton.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    @IBAction func backToSignUpTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func visibilityConformPassword(sender: UIButton) {
        isPasswordVisible1.toggle()
        confirmPasswordTextField.isSecureTextEntry = !isPasswordVisible1
        let imageName1 = isPasswordVisible1 ? "eye.fill" : "eye.slash.fill"
        confromPasswordVisibleButton.setImage(UIImage(systemName: imageName1), for: .normal)
    }
    @IBAction func signupButtonClicked(sender: UIButton){
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let conformPassword = confirmPasswordTextField.text else{
            return
        }
        
        if !(isValidateEmail(email: email)){
            showAlert("Enter valid email address")
            return
        }
//        if !(isValidPassword(password: password)){
//            showAlert( "Password should be atleast 8 characters long,1 upppercase, 1 lowercase, 1 digit")
//            return
//        }
        if password != conformPassword{
            showAlert("Password does not match")
            return
        }
//        print("sinup successful")
//        errorLabel.isHidden = true
        postSignup(name: "NewUser1", email: email, password: password)
    }
    
//    func showAlert(_ message: String){
//        errorLabel.isHidden = false
//            errorLabel.text = message
//
//    }
    func showAlert(_ messgae: String){
        let alert = UIAlertController(title: "Alert", message: messgae, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func isValidateEmail(email: String) -> Bool {
        let regexEmail = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9]{2,}"
        return NSPredicate(format: "SELF MATCHES %@",regexEmail).evaluate(with: email)
        
    }
    func isValidPassword(password: String) -> Bool{
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[@!#$&^*]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@",passwordRegex).evaluate(with: password)
    }
    // MARK: - Signup API Call
        func postSignup(name: String, email: String, password: String) {
            guard let url = URL(string: "https://api.escuelajs.co/api/v1/users/") else {
                showAlert("❌ Invalid signup URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let signupData: [String: Any] = [
                "name": name,
                "email": email,
                "password": password,
               "avatar": "https://i.pravatar.cc/150?img=\(Int.random(in: 1...70))"
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: signupData, options: [])
                request.httpBody = jsonData
            } catch {
                showAlert("❌ Failed to encode signup data")
                return
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showAlert("⚠️ Signup failed: \(error.localizedDescription)")
                        return
                    }

                    guard let httpResponse = response as? HTTPURLResponse else {
                        self.showAlert("⚠️ Invalid server response")
                        return
                    }

                    print("📬 Status Code: \(httpResponse.statusCode)")
                    
                    if let data = data,
                       let body = String(data: data, encoding: .utf8) {
                        print("📨 Response: \(body)")
                    }

                    if httpResponse.statusCode == 201 {
                        self.errorLabel.isHidden = true
                        print("✅ Signup successful!")

                        // Navigate to Login screen
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.showAlert("⚠️ Signup failed. Try a different email.")
                    }
                }
            }

            task.resume()
        }
    
}
