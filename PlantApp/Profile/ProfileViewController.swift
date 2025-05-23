//
//  ProfilleViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 19/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var ageTextField: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var genderTextField: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var heightTextField: UILabel!
    @IBOutlet weak var bloodGroup: UILabel!
    @IBOutlet weak var bloodGroupTextField: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var birthDateTextField: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var phoneNumberTextField: UILabel!
    
    
    var isEditMode = false
    let viewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchUserDetails()
        setUpView()
        
        //bindViewModel()
        

    }
    private func setUpView() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        view.layer.cornerRadius = 10
        disableTextFields()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(pushToEditCotroller))
    }
    
//when we use closure to pass data
    //private func bindViewModel(){
//        viewModel.isProfileDataUpdated = { [weak self] user in
//            DispatchQueue.main.async {
//                self?.updateUI(user)
//            }
//        }
//    }
    private func updateUI(data: UserModel) {
                DispatchQueue.main.async {
                    self.fullName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
                    self.userName.text = "Username: \(data.username ?? "-")"
                    self.ageTextField.text = "\(data.age ?? 0)"
                    self.genderTextField.text = data.gender?.capitalized ?? "-"
                    self.emailTextField.text = data.email ?? "-"
                    self.heightTextField.text = "\(data.height ?? 0.0) cm"
                    self.bloodGroupTextField.text = data.bloodGroup ?? "-"
                    self.birthDateTextField.text = data.birthDate ?? "-"
                    self.phoneNumberTextField.text = data.phone ?? "-"

                    // Load profile image
                    if let urlString = data.image {
                        ApiServices.shared.loadImage(from: urlString) { image in
                            self.profileImage.image = image
                        }
                    }
                }
    }
    private func disableTextFields(){
        [ageTextField,genderTextField,emailTextField,heightTextField,bloodGroupTextField,birthDateTextField,phoneNumberTextField].forEach({$0?.isUserInteractionEnabled = false})
    }
    @objc private func pushToEditCotroller(){
        let editVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        editVC.selectedProfileDetails = viewModel.profileDetails
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
        
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    func updateProfileDetails(user: UserModel) {
        self.updateUI(data: user)
    }
    func didReciveError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
}

extension ProfileViewController: EditViewControllerDelegate{
    func didUpdateProfile(_ userProfile: UserModel) {
        viewModel.profileDetails = userProfile
        updateUI(data: userProfile)
    }
    
   
}
