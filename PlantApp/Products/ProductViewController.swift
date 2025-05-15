//
//  ProductViewController.swift
//  PracticeUIKit
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var selectedCategory: CategoriesModel2?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
    var products = [ProductModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView1.register(ProductCell.nib(), forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        callProductsAPI()

    }
       
   
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(products.count)
            return products.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let product = products[indexPath.item]
            //cell.backgroundColor = .white
            cell.configure(with: product)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = (UIScreen.main.bounds.width/2) - 20
            return CGSize(width: screenWidth, height: screenWidth) // Adjust height as needed
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailedVc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController{
            detailedVc.product = selectedProduct
            self.navigationController?.pushViewController(detailedVc, animated: true)
            
        }
    }
        
    func callProductsAPI(){
        // step 1
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        let urlString = "https://api.escuelajs.co/api/v1/products?categoryId=\(selectedCategory?.id ?? 1)"
//        ApiServices.shared.fetchData(from: urlString, model: [ProductModel].self){ [weak self] result in
//            // Step 3: Handle the result
//            DispatchQueue.main.async {
//                self?.activityIndicator.stopAnimating()
//                self?.activityIndicator.isHidden = true
//                
//                switch result {
//                case .success(let fetchedProducts):
//                    // Store the result in the products property
//                    self?.products = fetchedProducts
//                    // Optionally, update the UI (e.g., reload a table view)
//                    // self?.tableView.reloadData()
//                case .failure(let error):
//                    // Handle the error (e.g., show an alert)
//                    print("Error fetching products: \(error.localizedDescription)")
//                }
//            }
             //step 2
                        guard let url = URL(string: urlString) else {
                            print("Invalid URL")
                            return
                        }
                        
                        // step 3
                        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in  DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            
                        }
                            
                            guard let data = data else {
                                return
                            }
                            do {
                                let decoder = JSONDecoder()
                                let products = try decoder.decode([ProductModel].self, from: data)
                                self.products = products
                                DispatchQueue.main.async {
                                    self.collectionView1.reloadData()
                                }
                                
                                
                            } catch {
                                
                            }
                        }
                        task.resume()
                        
        }
    }
extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    // Cell spacing from edges
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    // Vertical spacing between rows
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

//    // Horizontal spacing between items
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
