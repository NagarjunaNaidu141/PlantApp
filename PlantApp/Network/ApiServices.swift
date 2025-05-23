//
//  ApiCall.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 14/05/25.
//

import Foundation
import UIKit
//This is your custom network service class to handle API calls in one place — following the singleton pattern.
class ApiServices {
    //This creates a shared instance of APIService that can be used throughout your app ✅ Singleton Benefit: Only one instance exists in memory, making it easy to reuse.
    static let shared = ApiServices()
    
    //Prevents other parts of the code from creating new instances of APIService. Enforces singleton usage.
    private init(){
        
    }
    /*This is a generic function that:
    Accepts any Decodable model type (T)
    Accepts a urlString
    Provides a completion block with Result<T, Error>
    🧠 T: Decodable means it can decode any model you pass.
 */

    func fetchData<T: Decodable>(from urlString: String,model :T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        //It checks if the URL is valid. If not, it returns an error through the completion.
        
        guard let url = URL(string: urlString) else{
            completion(.failure(NSError(domain: "Invalid Url", code: -1)))
            return
        }
        //This is the actual network request that runs in the background and fetches data from the given URL.
        

        URLSession.shared.dataTask(with: url){ data, response, error in
            //Handles basic network errors (like no internet).
            if let error = error{
                completion(.failure(error))
                return
            }
            //Checks whether any data was returned before trying to decode.
            guard let data = data else{
                completion(.failure(NSError(domain: "no data", code: -2)))
                return
            }
            do {
            //Attempts to decode the data into the model type you specified. If decoding succeeds, the result is passed to the completion as .success.
                let decodedData = try JSONDecoder().decode(model, from: data)
                completion(.success(decodedData))
            }
            //If decoding fails (e.g., mismatched model structure), it reports a decoding error via .failure.
            catch {
                completion(.failure(error))
            }
        } .resume()
        
    }
    
    func loadImage(from urlString : String,completion: @escaping (UIImage?)-> Void){
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
      
        URLSession.shared.dataTask(with: url){ data,_,error in
            if let data = data, error == nil, let image = UIImage(data: data){
                DispatchQueue.main.async{
                    completion(image)
                }
            }else{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        } .resume()
    }
    
}
/*
 ✅ completion
 This is the name of the parameter. It's a closure (a block of code you can pass around like a variable). You call this closure when you're done loading the image — whether it's successful or failed.

 ✅ @escaping
 This means the closure "escapes" the scope of the function. In simpler terms:

 You're calling this closure after the function loadImage() returns — asynchronously.

 This is required because you're using URLSession (which is async).

 Without @escaping, the closure would have to be used before the function exits, which isn’t the case with network calls.

 ✅ (UIImage?) -> Void
 This is the type of the closure. It’s a function that:

 Takes one parameter: UIImage? (an optional image — it could be an actual image or nil if failed)

 Returns nothing (Void)
 */
/*
 What is DispatchQueue.main.async?
 ➤ DispatchQueue.main
 This refers to the main thread of your iOS app. It's where all UI updates must happen.

 ➤ .async { ... }
 This means: run this block of code asynchronously (later) on that queue — in this case, the main thread.

 Why do we use it here?
 ✅ Network calls happen in the background (not on the main thread).
 When you use URLSession.shared.dataTask(...), it runs on a background thread to avoid freezing the UI.

 This is good — network calls can be slow, and running them in the background keeps your app responsive.

 ❗ But you CANNOT update the UI from a background thread.
 UIKit is not thread-safe.

 That means, if you try to set an image to a UIImageView directly from a background thread, your app could crash or behave unpredictably.


 */
