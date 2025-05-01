////
////  HorizontalImageScroll.swift
////  PlantApp
////
////  Created by Nagarjuna Naidu on 01/05/25.
////
//
//import UIKit
////import Kingfisher
//
//class HorizontalImageScroll: UICollectionViewCell {
//    
//    @IBOutlet weak var imageScroll: UIImageView!
//    
//    static let identifier = "HorizontalImageScroll"
//    static func nib() -> UINib{
//        return UINib(nibName: "HorizontalImageScroll", bundle: nil)
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//    }
//    func configure(with urlString: String) {
//        imageScroll.image = UIImage(named: "plant")
//        guard let url = URL(string: urlString) else {return}
//        
//        URLSession.shared.dataTask(with: url){ data, response, error in
//            guard let data = data , let image = UIImage(data:data) else {
//                print("Image load error: \(error?.localizedDescription ?? "unknown")")
//                return
//            }
//            DispatchQueue.main.async {
//                self.imageScroll.image = image
//            }
//            
//        }.resume()
//    }
//}


import UIKit
import Kingfisher

class HorizontalImageScroll: UICollectionViewCell {
    
    @IBOutlet weak var imageScroll: UIImageView!
    
    static let identifier = "HorizontalImageScroll"
    
    static func nib() -> UINib {
        return UINib(nibName: "HorizontalImageScroll", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with urlString: String) {
        imageScroll.kf.indicatorType = .activity // optional loading spinner
        
        guard let url = URL(string: urlString) else {
            imageScroll.image = UIImage(named: "plant") // fallback image
            return
        }
        
        imageScroll.kf.setImage(
            with: url,
            placeholder: UIImage(named: "plant")
        )
    }
}
