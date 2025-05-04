//
//  CartViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 02/05/25.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CartCollectionViewCell.nib(), forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        
        
    }
     
    
    

}
