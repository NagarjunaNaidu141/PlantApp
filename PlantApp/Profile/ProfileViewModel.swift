//
//  ProfileViewModel.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 19/05/25.
//



import Foundation


class ProfileViewModel{

    var profileDetails: UserModel?
    
    //closure to notify view controller when profile data is updated
    //var isProfileDataUpdated : ((UserModel) -> Void)?
    weak var delegate: ProfileViewDelegate?
    
    func fetchUserDetails(){
        let urlString = "https://dummyjson.com/users/22"
        ApiServices.shared.fetchData(from: urlString, model: UserModel.self) { [weak self] result in
            switch result{
            case .success(let user):
                self?.profileDetails = user
                self?.delegate?.updateProfileDetails(user: user)
            case .failure(let failure):
                print("error message \(failure)")
                self?.delegate?.didReciveError(failure)
            }
        }
    }
}
protocol ProfileViewDelegate: AnyObject{
    func updateProfileDetails(user: UserModel)
    
    func didReciveError(_ error: Error)
}
