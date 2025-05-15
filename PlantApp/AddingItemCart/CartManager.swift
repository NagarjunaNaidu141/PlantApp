//
//  CartManager.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 13/05/25.
//

class CartManager{
    /*
     CartManager() is the constructor that creates an object of the CartManager class.

     static let shared makes that object shared globally — accessible from anywhere in your app via CartManager.shared.
     */
    static let shared = CartManager()
    private init(){}
    
    private var cartItems: [ProductModel] = []
    
    func addCartItem(product: ProductModel){
        if !cartItems.contains(where: { $0.id == product.id}){
            cartItems.append(product)
        }
    }
    func getCartItems() -> [ProductModel]{
        return cartItems
    }
    func removeCartItem(product:ProductModel){
        if let index = cartItems.firstIndex(where: { $0.id == product.id}){
            cartItems.remove(at: index)
        }
    }
}
