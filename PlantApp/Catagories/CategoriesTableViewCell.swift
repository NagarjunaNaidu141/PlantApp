//
//  CategoriesTableViewCell.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 18/05/25.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categorynameLabel: UILabel!
    @IBOutlet weak var categoryidLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryCreationAtLabel: UILabel!
    @IBOutlet weak var categoryUpdatedAtLabel: UILabel!
    
    static let identifier = "CategoriesTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CategoriesTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with category: CategoriesModel2) {
        categorynameLabel.text = category.name
        categoryidLabel.text = "\(category.id ?? 20)"
        categoryCreationAtLabel.text = "created at\(category.creationAt ?? "2025")"
        categoryUpdatedAtLabel.text = "updated at \(category.updatedAt ?? "2025")"
        
        //categoryImage.image = UIImage(named: "\(category.image ?? "plant")")
        if let urlString = category.image, let url = URL(string: urlString) {
            // Example using URLSession or third-party like SDWebImage
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.categoryImage.image = image
                    }
                }
            }.resume()
        }

    }
    
}
