//
//  ProductDetailsViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 05/04/25.
//

import UIKit

class ProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var product: ProductModel?

    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let product = product {
            label1.text = product.title
            label2.text = "$\(product.price)"
            label3.text = product.category.name
           
            
        }
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(HorizontalImageScroll.nib(), forCellWithReuseIdentifier: HorizontalImageScroll.identifier)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("image count \(product?.images.count ?? 10) ")
        return product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalImageScroll", for: indexPath) as! HorizontalImageScroll
        if let imageUrl = product?.images[indexPath.row] {
            cell.configure(with: imageUrl)
        }
        print(product?.images[indexPath.row] ?? "plant")
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           return imageCollectionView.frame.size
//       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

//    private func loadImage(from urlString: String) {
//        guard let url = URL(string: urlString) else {
//            self.image1.image = UIImage(named: "plant")
//            return
//        }
//
//        // Optional: set placeholder
//        self.image1.image = UIImage(named: "plant")
//
//        // Start background download
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil, let image = UIImage(data: data) else {
//                DispatchQueue.main.async {
//                    self.image1.image = UIImage(named: "plant") // fallback
//                }
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.image1.image = image
//            }
//        }.resume()
//    }
//
//    
//
//    
//    private func downloadImage(from url: URL) async -> UIImage? {
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            return UIImage(data: data)
//        } catch {
//            print("Failed to download image:", error)
//            return UIImage(named: "default")
//        }
//    }
    

    

}
