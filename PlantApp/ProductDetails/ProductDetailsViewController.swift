//
//  ProductDetailsViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 05/04/25.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    var product: ProductModel?

    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let product = product {
            label1.text = product.title
            label2.text = "$\(product.price)"
            label3.text = product.category.name
            
        }
    }
    

    

}
