//
//  ViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 06/11/23.
//

import UIKit
import Kingfisher


class ProductListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ProductListViewModelAction {
    
    
    var productListViewModel = ProductListViewModel()
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BROWSE"
//        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
       
        
        productListViewModel.delegate = self
        showActivityIndicator()
        
    }
    
    private func showActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListViewModel.fetchProduct()
    }
    
    func didFinishFetchingProducts() {
        print("Products count after fetching")
        hideActivityIndicator()
        self.collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productDetailViewModel = productListViewModel.productDetailViewModel(at: indexPath.item)
        else {
            return
        }
        self.performSegue(withIdentifier: "DetailSegue", sender: productDetailViewModel)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductDetailViewController,
           let productDetailViewModel = sender as? ProductDetailViewModel,
           segue.identifier == "DetailSegue" {
            destinationVC.productDetailViewModel = productDetailViewModel
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListViewModel.productCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! ProductCell
        configureCell(cell, at: indexPath)
        return cell
        
    }
    
    func configureCell (_ cell: ProductCell , at indexPath: IndexPath ) {
        guard let product = productListViewModel.products(at: indexPath.item) else{
            return
        }
        cell.productNameLabel.text = product.node.name
        cell.productNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        if let imageURLString = product.node.images.first?.url,
           let imageURL = URL(string: imageURLString) {
            cell.productImageView.kf.setImage(with: imageURL)
        }
    }
    
    
}


