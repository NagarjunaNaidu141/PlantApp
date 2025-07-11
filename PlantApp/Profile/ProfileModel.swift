//
//  ProfileModel.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 19/05/25.
//

import Foundation



struct UserModel: Codable{
    var id: Int?
    var firstName: String?
    var lastName: String?
    var maidenName: String?
    var age: Int?
    var gender: String?
    var email: String?
    var phone: String?
    var username: String?
    var password: String?
    var birthDate: String?
    var image: String?
    var bloodGroup: String?
    var height: Double?
    var weight: Double?
    var eyeColor: String?
    var address: Address?
    var country: String?
    var university: String?
    var company: Company?
    var role: String?
    
    
}
struct Company: Codable{
    var department: String?
    var name: String?
    var address: Address?
    var phone: String?
    var website: String?
    var title: String?
    var country: String?
    
    
}
struct Address: Codable{
    var address: String?
    var city: String?
    var state: String?
    var stateCode: String?
    var postalCode: String?
    var coordinates: Coordinates?
    
  
}
struct Coordinates: Codable{
    var lat: Double?
    var lng: Double?
}
/*
{
  "id": 22,
  "firstName": "Elijah",
  "lastName": "Stewart",
  "maidenName": "",
  "age": 33,
  "gender": "male",
  "email": "elijah.stewart@x.dummyjson.com",
  "phone": "+44 468-357-7872",
  "username": "elijahs",
  "password": "elijahspass",
  "birthDate": "1991-10-22",
  "image": "https://dummyjson.com/icon/elijahs/128",
  "bloodGroup": "A-",
  "height": 195.33,
  "weight": 81.64,
  "eyeColor": "Blue",
  "hair": {
    "color": "Purple",
    "type": "Straight"
  },
  "ip": "23.87.135.62",
  "address": {
    "address": "1701 Eighth Street",
    "city": "Columbus",
    "state": "Illinois",
    "stateCode": "IL",
    "postalCode": "31585",
    "coordinates": {
      "lat": -54.833799,
      "lng": -174.504027
    },
    "country": "United States"
  },
  "macAddress": "75:17:c6:35:fc:6d",
  "university": "Georgetown University",
  "bank": {
    "cardExpire": "05/27",
    "cardNumber": "0798116671286564",
    "cardType": "JCB",
    "currency": "GBP",
    "iban": "E1XUHCC1N39WGU6XESSK1CAO"
  },
  "company": {
    "department": "Legal",
    "name": "Langworth Group",
    "title": "Business Analyst",
    "address": {
      "address": "155 Ninth Street",
      "city": "Washington",
      "state": "South Dakota",
      "stateCode": "SD",
      "postalCode": "19039",
      "coordinates": {
        "lat": 61.279254,
        "lng": -12.607767
      },
      "country": "United States"
    }
  },
  "ein": "520-394",
  "ssn": "287-380-801",
  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36",
  "crypto": {
    "coin": "Bitcoin",
    "walvar": "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a",
    "network": "Ethereum (ERC20)"
  },
  "role": "user"
}

*/

