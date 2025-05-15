//
//  ProductCell.swift
//  PracticeUIKit
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var titleLable : UILabel!
    @IBOutlet weak var priceLable : UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var productImage: UIImageView!
   
    
    static let identifier = "ProductCell"
    static func nib() -> UINib {
        return UINib(nibName: "ProductCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
       
    }
    func configure(with product: ProductModel) {
        titleLable.text = product.title
        priceLable.text = "$\(product.price)"
        categoryLabel.text = product.category.name
        
        if let imageUrlString = product.images.first {
            //loadImage(from: imageUrlString)
            ApiServices.shared.loadImage(from: imageUrlString) { [weak self] image in
                
                self?.productImage.image = image ?? UIImage(named: "plant")
            }
        }else {
            self.productImage.image = UIImage(named: "plant")
        }
    }

//    private func loadImage(from urlString: String) {
//        guard let url = URL(string: urlString) else {
//            self.productImage.image = UIImage(named: "plant")
//            return
//        }
//
//        // Optional: Set placeholder first while loading
//        self.productImage.image = UIImage(named: "plant")
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil, let image = UIImage(data: data) else {
//                DispatchQueue.main.async {
//                    self.productImage.image = UIImage(named: "plant") // fallback if loading fails
//                }
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.productImage.image = image
//            }
//        }.resume()
//    }


}
