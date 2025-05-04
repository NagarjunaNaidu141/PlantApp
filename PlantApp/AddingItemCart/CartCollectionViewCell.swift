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
    
    static var identifier = "CartCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CartCollectionViewCell", bundle: nil)
    }
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with viewModel: ProductModel) {
        if let imageUrlString = viewModel.images.first {
            loadImage(from: imageUrlString)
        } else {
            self.itemImageView.image = UIImage(named: "plant")
        }
        productNameLabel.text = viewModel.title
        priceLabel.text = "$\(viewModel.price)"
    }
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            self.itemImageView.image = UIImage(named: "plant")
            return
        }

        // Optional: Set placeholder first while loading
        self.itemImageView.image = UIImage(named: "plant")

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.itemImageView.image = UIImage(named: "plant") // fallback if loading fails
                }
                return
            }

            DispatchQueue.main.async {
                self.itemImageView.image = image
            }
        }.resume()
    }
}
