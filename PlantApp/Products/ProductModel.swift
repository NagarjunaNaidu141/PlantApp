//
//  ProductModel.swift
//  PracticeUIKit
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

struct ProductModel: Codable {
    let id: Int
    let title: String
    let slug: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
    let slug: String
}


//[
//  {
//    "id": 4,
//    "title": "Handmade Fresh Table",
//    "slug": "handmade-fresh-table",
//    "price": 687,
//    "description": "Andy shoes are designed to keeping in...",
//    "category": {
//      "id": 5,
//      "name": "Others",
//      "image": "https://placehold.co/600x400",
//      "slug": "others"
//    },
//    "images": [
//      "https://placehold.co/600x400",
//      "https://placehold.co/600x400",
//      "https://placehold.co/600x400"
//    ]
//  }
//  // ...
//]
