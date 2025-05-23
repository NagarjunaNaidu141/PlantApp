//
//  EditViewModel.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 21/05/25.
//

import Foundation

class EditViewModel{
    func calculateAge(from birthdate: Date) -> Int{
        let calender = Calendar.current
        let now = Date()
        let ageComponent = calender.dateComponents([.year], from: birthdate, to: now)
        
        return ageComponent.year ?? 0
    }
    
    func isValidateEmail(_ email: String) -> Bool{
        let regex = "[A-Za-z0-9.+_%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    func isValidatePhoneNumber(_ phoneNumber: String) -> Bool{
        let regex = "[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
        
    }
    
}
//The $ is crucial because it enforces that there are no additional characters following the 10 digits, making it a precise match for a 10-digit phone number.
