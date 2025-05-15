//
//  CartViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 02/05/25.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CartCollectionViewCellDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CartCollectionViewCell.nib(), forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartManager.shared.getCartItems().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as! CartCollectionViewCell
        let product = CartManager.shared.getCartItems()[indexPath.item]
        cell.configure(with: product)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200) // Adjust height as needed
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    // step - 3 implementing delegate
    func didTapRemoveButton(on cell: CartCollectionViewCell) {
        
        if let indexPath = collectionView.indexPath(for: cell) {
            let product = CartManager.shared.getCartItems()[indexPath.item]
            CartManager.shared.removeCartItem(product: product)
            collectionView.deleteItems(at: [indexPath])
            
            print("Items after removal:", CartManager.shared.getCartItems().count)
                    
                    // Force refresh
                    collectionView.reloadData()
            
        }
    }
}
