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
    
    static let identifier = "ProductCell"
    static func nib() -> UINib {
        return UINib(nibName: "ProductCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with product: ProductModel) {
        titleLable.text = product.title
        priceLable.text = "$\(product.price)"
            categoryLabel.text = product.category.name

        }

}
