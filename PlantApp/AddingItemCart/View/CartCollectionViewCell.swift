//
//  CartCollectionViewCell.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 03/05/25.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var unitPrice : Double = 0.0
    
    //step -2 Add a delegate property
    weak var delegate: CartCollectionViewCellDelegate?
    private var quantity:  Int = 1{
        didSet{
            quantityTextField.text = "\(quantity)"
            updatePrice()
        }
    }
    
    static var identifier = "CartCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CartCollectionViewCell", bundle: nil)
    }
   

    override func awakeFromNib() {
        super.awakeFromNib()
       
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        quantityTextField.text = "\(quantity)"
        
    }

    func configure(with viewModel: ProductModel) {
        if let imageUrlString = viewModel.images.first {
            
            ApiServices.shared.loadImage(from: imageUrlString) { [weak self] image in
                
                self?.itemImageView.image = image ?? UIImage(named: "plant")
            }
            //loadImage(from: imageUrlString)
        }
         else {
            self.itemImageView.image = UIImage(named: "plant")
        }
        productNameLabel.text = viewModel.title
        unitPrice = viewModel.price
        quantity = 1
        updatePrice()
    }
    
    func updatePrice() {
        priceLabel.text = "$\(unitPrice * Double(quantity))"
    }
    @IBAction func didTapIncrease(sender: UIButton){
        quantity += 1
    }
    @IBAction func didTapDecrease(sender: UIButton){
        if quantity > 1{
            quantity -= 1
        }
    }
    //step 2.1 and wire up the remote button
    @IBAction func remove(sender: UIButton){
        print("remove button tapped")
        delegate?.didTapRemoveButton(on: self)
    }
    @IBAction func BuyThisNow(sender: UIButton){
        
    }
//    private func loadImage(from urlString: String) {
//        guard let url = URL(string: urlString) else {
//            self.itemImageView.image = UIImage(named: "plant")
//            return
//        }
//
//        // Optional: Set placeholder first while loading
//        self.itemImageView.image = UIImage(named: "plant")
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil, let image = UIImage(data: data) else {
//                DispatchQueue.main.async {
//                    self.itemImageView.image = UIImage(named: "plant") // fallback if loading fails
//                }
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.itemImageView.image = image
//            }
//        }.resume()
//    }
}

//step -1  Create a delegate protocol

protocol CartCollectionViewCellDelegate: AnyObject{
    func didTapRemoveButton(on cell: CartCollectionViewCell)
}
