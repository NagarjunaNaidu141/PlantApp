//
//  ViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 01/04/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var emailIdText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    var isPasswordVisible = false
    
   // let users:[String: String] = ["nagarjuna@gmail.com": "Welcome@1", "nag@gmail.com": "Nag@12311", "nag123@gmail.com": "Welcome123"]
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        emailIdText.delegate = self
        passwordText.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
     
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func visibiltyPassword(sender: UIButton){
       isPasswordVisible.toggle()
        passwordText.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye.fill" : "eye.slash.fill"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //@IBAction func loginButtonTapped(_ sender: Any) {
//        guard let email = emailIdText.text, let password = passwordText.text else {
//            return
//        }
//        if email.isEmpty || password.isEmpty {
//            showAlert("Email id or password is empty")
//        }else if let storedPassword = users[email], storedPassword == password {
//            errorLabel.isHidden = true
//            print("Login successfull")
//        }else {
//
//            showAlert("Invalid email id or password")
//
//        }
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        if let categoriesViewController = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as? CategoriesViewController {
    //            self.navigationController?.pushViewController(categoriesViewController, animated: true)
    //        }
    
        @IBAction func loginButtonTapped(_ sender: Any) {
            guard let email = emailIdText.text, let password = passwordText.text else {
                return
            }
            
            if email.isEmpty || password.isEmpty {
                showAlert("Email id or password is empty")
                return
            }
            
            // 🔐 Replace local check with real API call
            postLogin(email: email, password: password)
        }
    
//    func showAlert(_ message: String) {
//        errorLabel.text = message
//        errorLabel.isHidden = false
//    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let createAccountViewController = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController {
            self.navigationController?.pushViewController(createAccountViewController, animated: true)
        }
        
    }
    func postLogin(email: String, password: String) {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/auth/login") else {
            print("❌ Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginData = ["email": email, "password": password]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
            request.httpBody = jsonData
        } catch {
            print("❌ Failed to encode JSON: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert("Request error: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.showAlert("Invalid response from server")
                    return
                }

                print("📩 Status Code: \(httpResponse.statusCode)")

                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201{
                    // ✅ Login success
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    self.errorLabel.isHidden = true

                   // let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    if let categoriesViewController = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as? CategoriesViewController {
//                        self.navigationController?.pushViewController(categoriesViewController, animated: true)
//                    }
//                    if let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBar {
//                        self.navigationController?.pushViewController(tabBar, animated: true)
//                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)

                    if  let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarV{
                        tabBarController.selectedIndex = 0 // 0 for first tab, which is CategoriesViewController
                        tabBarController.modalPresentationStyle = .fullScreen
                        self.present(tabBarController, animated: true, completion: nil)

                    }

                    
                } else {
                    // ❌ Login failed
                    self.showAlert("Invalid email or password")
                }
            }
        }

        task.resume()
    }
    
}

