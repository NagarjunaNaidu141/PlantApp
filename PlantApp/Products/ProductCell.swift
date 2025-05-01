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
        // Initialization code
    }
//    func configure(with product: ProductModel) {
//        titleLable.text = product.title
//        priceLable.text = "$\(product.price)"
//        categoryLabel.text = product.category.name
//        self.productImage.image = loadImage(from: product.images.first!)
//
//        }
//    private func loadImage(from url: String) -> UIImage? {
//        
//        guard let url = URL(string: url) else {
//            return UIImage(named: "plant")
//        }
//        Task {
//            if let loadedImage = await downloadImage(from: url) {
//                return loadedImage
//            }
//            return UIImage(named: "plant")!
//        }
//        return UIImage(named: "plant")
//    }
//
    
    func configure(with product: ProductModel) {
        titleLable.text = product.title
        priceLable.text = "$\(product.price)"
        categoryLabel.text = product.category.name
        
        if let imageUrlString = product.images.first {
            loadImage(from: imageUrlString)
        } else {
            self.productImage.image = UIImage(named: "plant")
        }
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            self.productImage.image = UIImage(named: "plant")
            return
        }

        // Optional: Set placeholder first while loading
        self.productImage.image = UIImage(named: "plant")

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(named: "plant") // fallback if loading fails
                }
                return
            }

            DispatchQueue.main.async {
                self.productImage.image = image
            }
        }.resume()
    }

    private func downloadImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Failed to download image:", error)
            return UIImage(named: "default")
        }
    }

}
