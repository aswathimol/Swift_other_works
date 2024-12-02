//
//  ViewController.swift
//  ProductCart1
//
//  Created by Aswathimol S(UST,IN) on 18/10/23.
//

import UIKit
import Kingfisher

class ProductListViewModel {
    
}

class ProductListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let viewModel = ProductListViewModel()
    var products: [Product] = []
    @IBOutlet var collectionView: UICollectionView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // collectionView.backgroundColor = .brown
        ProductDetails.getProducts { [weak self] products in
                    self?.products = products
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: selectedProduct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destinationVC = segue.destination as? ProductDetailViewController, let selectedProduct = sender as? Product {
                destinationVC.product = selectedProduct
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductListCell
        let product = products[indexPath.row]
    
        
        let priceString = String(product.price)
        cell.priceLabel.text = "$ \(priceString) ea"
        cell.priceLabel.font =  UIFont.boldSystemFont(ofSize: 16.0)
        cell.titleLabel.text = product.title
        
        if let imageURL = URL(string: product.image) {
            cell.imageView.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    
    
}






