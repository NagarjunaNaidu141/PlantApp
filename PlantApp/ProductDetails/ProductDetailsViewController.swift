//
//  ProductDetailsViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 05/04/25.
//

import UIKit

class ProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    var product: ProductModel?
    var timer: Timer?
    var currentIndex: Int = 0
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productCategoryName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //@IBOutlet weak var cartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let product = product {
            productTitle.text = product.title
            productPrice.text = "$\(product.price)"
            productCategoryName.text = product.category.name
            pageControl.numberOfPages = product.images.count
            pageControl.currentPage = 0
            pageControl.isHidden = product.images.count <= 1
        }
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(HorizontalImageScroll.nib(), forCellWithReuseIdentifier: HorizontalImageScroll.identifier)
        if let layout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        imageCollectionView.isPagingEnabled = true
        startAutoScroll()
        
        
    }
    func stopAutoScroll(){
        timer?.invalidate()
        timer = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScroll()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAutoScroll()
    }
    func startAutoScroll(){
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollAutomatically), userInfo: nil, repeats: true)
    }
    @objc func scrollAutomatically(){
        
        guard let product = product else{return}
        let index = IndexPath(item: currentIndex, section: 0)
        
        //Checks if the current image index is not at the end of the image list.
        print("CurrentIndex:\(currentIndex)")
        print("Products Count:\(product.images.count)")
        if currentIndex < product.images.count {
            imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            currentIndex += 1
            //self.pageControl.currentPage = self.currentIndex
        }else{
            currentIndex = 0
            let index1 = IndexPath(item: currentIndex, section: 0)
            imageCollectionView.scrollToItem(at: index1, at: .centeredHorizontally, animated: false)
            // currentIndex = 1
            //self.pageControl.currentPage = self.currentIndex
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        imageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentIndex = sender.currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("image count \(product?.images.count ?? 10) ")
        return product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalImageScroll.identifier, for: indexPath) as! HorizontalImageScroll
        if let imageUrl = product?.images[indexPath.row] {
            cell.configure(with: imageUrl)
        }
        print(product?.images[indexPath.row] ?? "plant")
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func cartButtonTapped(sender: UIButton){
        guard let product = product else { return }
        
        CartManager.shared.addCartItem(product: product)
        let alert = UIAlertController(title: "Success", message: "Product added to cart", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}

