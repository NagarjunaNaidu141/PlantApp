//
//  LogOutViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 06/04/25.
//

import UIKit

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func logoutButton(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        //UserDefaults.standard.synchronize()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.view.window?.rootViewController = navController
                self.view.window?.makeKeyAndVisible()
            }
        
    }
    
}
