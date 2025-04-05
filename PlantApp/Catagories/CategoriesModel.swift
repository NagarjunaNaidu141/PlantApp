//
//  CategoriesModel.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

// codeable, Decodable, Encodable -> learn about this


//struct CategoriesArray: Codable {
//    let data: [CategoriesModel]?
//}
//
//// Way 1
//struct CategoriesModel: Codable {
//    let id: Int?
//    let name: String?
//    let slug: String?
//    let image: String?
//    let creationAt: String?
//    let updatedAt: String?
//}

// Way 2

struct CategoriesModel2: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let image: String?
    let creationAt: String?
    let updatedAt: String?
    
//   enum codingKeys: String, CodingKey {
//      case userID = "id"
//       case userName = "name"
//       case slug
//        case image
//       case creationAt
//        case updatedAt
//    }
}


////[
////    {
////        "id": 1,
////        "name": "Clothes",
////        "slug": "clothes",
////        "image": "https://i.imgur.com/QkIa5tT.jpeg",
////        "creationAt": "2025-04-03T17:16:59.000Z",
////        "updatedAt": "2025-04-03T17:16:59.000Z"
////    },
////    {
////        "id": 2,
////        "name": "Electronics",
////        "slug": "electronics",
////        "image": "https://i.imgur.com/ZANVnHE.jpeg",
////        "creationAt": "2025-04-03T17:16:59.000Z",
////        "updatedAt": "2025-04-03T17:16:59.000Z"
////    },
////    {
////        "id": 3,
////        "name": "Furniture",
////        "slug": "furniture",
////        "image": "https://i.imgur.com/Qphac99.jpeg",
////        "creationAt": "2025-04-03T17:16:59.000Z",
////        "updatedAt": "2025-04-03T17:16:59.000Z"
////    },
////    {
////        "id": 4,
////        "name": "Shoes",
////        "slug": "shoes",
////        "image": "https://i.imgur.com/qNOjJje.jpeg",
////        "creationAt": "2025-04-03T17:16:59.000Z",
////        "updatedAt": "2025-04-03T17:16:59.000Z"
////    },
////    {
////        "id": 5,
////        "name": "Miscellaneous",
////        "slug": "miscellaneous",
////        "image": "https://i.imgur.com/BG8J0Fj.jpg",
////        "creationAt": "2025-04-03T17:16:59.000Z",
////        "updatedAt": "2025-04-03T17:16:59.000Z"
////    },
////    {
////        "id": 6,
////        "name": "NEW ARRIVALS",
////        "slug": "new-arrivals",
////        "image": "https://placeimg.com/640/480/any",
////        "creationAt": "2025-04-03T21:02:03.000Z",
////        "updatedAt": "2025-04-03T21:02:03.000Z"
////    },
////    {
////        "id": 10,
////        "name": "CASUALS",
////        "slug": "casuals",
////        "image": "https://placeimg.com/640/480/any",
////        "creationAt": "2025-04-03T21:23:37.000Z",
////        "updatedAt": "2025-04-03T21:23:37.000Z"
////    },
////    {
////        "id": 11,
////        "name": "Royal ItemS",
////        "slug": "royal-items",
////        "image": "https://i.imgur.com/49FiVI0.png",
////        "creationAt": "2025-04-03T23:19:35.000Z",
////        "updatedAt": "2025-04-03T23:19:35.000Z"
////    },
////    {
////        "id": 16,
////        "name": "New category",
////        "slug": "new-category",
////        "image": "https://placehold.co/600x400",
////        "creationAt": "2025-04-04T07:09:00.000Z",
////        "updatedAt": "2025-04-04T07:09:00.000Z"
////    },
////    {
////        "id": 17,
////        "name": "Jasur",
////        "slug": "jasur",
////        "image": "https://placeimg.com/640/480/any",
////        "creationAt": "2025-04-04T08:22:31.000Z",
////        "updatedAt": "2025-04-04T08:22:31.000Z"
////    },
////    {
////        "id": 18,
////        "name": "salom",
////        "slug": "salom",
////        "image": "https://placeimg.com/640/480/any",
////        "creationAt": "2025-04-04T09:11:56.000Z",
////        "updatedAt": "2025-04-04T09:11:56.000Z"
////    },
////    {
////        "id": 19,
////        "name": "string",
////        "slug": "string",
////        "image": "https://i.pravatar.cc/150?img=3",
////        "creationAt": "2025-04-04T10:00:55.000Z",
////        "updatedAt": "2025-04-04T10:00:55.000Z"
////    },
////    {
////        "id": 20,
////        "name": "333",
////        "slug": "333",
////        "image": "https://i.imgur.com/ZANVnHE.jpeg",
////        "creationAt": "2025-04-04T10:18:12.000Z",
////        "updatedAt": "2025-04-04T10:18:12.000Z"
////    },
////    {
////        "id": 21,
////        "name": "TERND",
////        "slug": "ternd",
////        "image": "https://picsum.photos/200",
////        "creationAt": "2025-04-04T14:29:02.000Z",
////        "updatedAt": "2025-04-04T14:29:02.000Z"
////    }
////]
//
//
//
//struct userDetails: Decodable {
//    let firstName: String?
//    let lastName: String?
//    let age:Int?
//    let address: [address]?
//    enum CodingKeys: String, CodingKey {
//        case age
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case address
//    }
//}
//struct address: Decodable {
//    let streetAddress: String
//    let city: String
//    let state: String
//    let postalCode: String
//    
//    enum CodingKeys: String, CodingKey {
//        case streetAddress = "street_address"
//        case city,state
//        case postalCode = "postal_code"
//    }
//}
//
//
//
//
//
//
//
//{
//  "first_name": "Jane",
//  "last_name": "Smith",
//  "age": 28,
//  "address": [{
//    "street_address": "123 Main St",
//    "city": "Anytown",
//    "state": "CA",
//    "postal_code": "90210"
//  },
//              {
//                "street_address": "123 Main St",
//                "city": "Anytown",
//                "state": "CA",
//                "postal_code": "90210"
//              },
//              {
//                "street_address": "123 Main St",
//                "city": "Anytown",
//                "state": "CA",
//                "postal_code": "90210"
//              }
//              
//  ]
//}
//
//
//
