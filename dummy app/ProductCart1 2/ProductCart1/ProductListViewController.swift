//
//  ViewController.swift
//  ProductCart1
//
//  Created by Aswathimol S(UST,IN) on 18/10/23.
//

import UIKit
import Kingfisher


class ProductListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProductListViewModelActions {
    
    
    let productListViewModel = ProductListViewModel()
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productListViewModel.delegate = self
        productListViewModel.fetchProducts()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListViewModel.fetchProducts()
    }
    
    func didFinishFetchingProducts() {
        self.collectionView.reloadData()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListViewModel.productsCount
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductListCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = productListViewModel.selectProduct(at: indexPath.item)
        else {
            return
        }
        self.performSegue(withIdentifier: "DetailSegue", sender: product)
    }
    
    func configureCell(_ cell: ProductListCell, at indexPath: IndexPath) {
        guard let product = productListViewModel.product(at: indexPath.item)
        else {
            return
        }
        let priceString = String(product.price)
        cell.priceLabel.text = "$ \(priceString) ea"
        cell.priceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.titleLabel.text = product.title

        if let imageURL = URL(string: product.image) {
            cell.imageView.kf.setImage(with: imageURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductDetailViewController,
           let productDetailViewModel = sender as? ProductDetailViewModel,
           segue.identifier == "DetailSegue"{
            destinationVC.productDetailViewModel = productDetailViewModel
        }
    }

}

