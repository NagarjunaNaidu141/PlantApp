//
//  ProductViewController.swift
//  PracticeUIKit
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var selectedCategory: CategoriesModel2?
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
    var products = [ProductModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView1.register(ProductCell.nib(), forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        callProductsAPI()
//        if let category = selectedCategory {
//            // Assuming 'allProducts' contains all products fetched from the API
//            products = products.filter { $0.category.id == category.id }
//            collectionView1.reloadData()
//        }
    }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(products.count)
            return products.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let product = products[indexPath.item]
            cell.backgroundColor = .red
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
            let urlString = "https://api.escuelajs.co/api/v1/products?categoryId=\(selectedCategory?.id ?? 1)"
            
            // step 2
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            // step 3
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
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
    
    private func loadImage(from url: String) -> UIImage? {
        
        guard let url = URL(string: url) else {
            return UIImage(named: "plant")
        }
        Task {
            if let loadedImage = await downloadImage(from: url) {
                return loadedImage
            }
            return UIImage(named: "plant")!
        }
        return UIImage(named: "plant")
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
