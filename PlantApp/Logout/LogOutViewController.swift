//
//  LogOutViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 06/04/25.
//

import UIKit

class LogOutViewController: UIViewController {
    var localizedUserDefaultKey = "localizedUserDefaultKey"
    var localizedDefaultLanguage = "en"

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        localizedDefaultLanguage = UserDefaults.standard.string(forKey: localizedUserDefaultKey) ?? "en"
        
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshLanguage()
    }
    @IBAction func englishLanguageButton(_ sender: UIButton) {
        localizedDefaultLanguage = "en"
        UserDefaults.standard.setValue(localizedDefaultLanguage, forKey: localizedUserDefaultKey)
        refreshLanguage()
    }
    @IBAction func hindiLanguageButton(_ sender: UIButton) {
        localizedDefaultLanguage = "hi-IN"
        UserDefaults.standard.setValue(localizedDefaultLanguage, forKey: localizedUserDefaultKey)
        refreshLanguage()
        
    }
    
    private func refreshLanguage(){
        label.text = "message".translated()
    }
    
}
extension String{
    func translated() -> String{
        let languageCode = UserDefaults.standard.string(forKey: "localizedUserDefaultKey") ?? "hi-IN"
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        
        return ""
    }
}
