//
//  ProductDetailListViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 20/11/23.
//

import Foundation
import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var productDetailViewModel: ProductDetailViewModel?
    var cartViewModel: CartViewModel?
    
    @IBOutlet var productScrollView: UIScrollView!
    
    @IBOutlet var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var recordLabel: UILabel!
    
    @IBOutlet var addToCart: UIButton!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let currentProductID = productDetailViewModel?.getCurrentVariantID() else {
            return
        }
        if let currentToken = ProductCategoryDetails.getCheckoutToken() {
            productDetailViewModel?.addToCart(checkoutToken: currentToken)
           self.showAlert(message: "Added to cart successfully")
           
           // self.showToast(message: "sdfghj", font: .boldSystemFont(ofSize: 12.0))
        }
        else {
            
            ProductCategoryDetails.createCart { [weak self] checkoutToken in
                guard let self = self else { return }
                print("Inside createCart: \(checkoutToken) ")
                
                if let checkoutToken = checkoutToken {
                    print("Checkout token received: \(checkoutToken)")
                    
                    ProductCategoryDetails.addToCart(checkoutToken: checkoutToken, productID: currentProductID) { success in
                        if success {
                            
                            print("Added to cart successfully .....")
                           
                            
                        }
                    }
                }
                else {
                    print("Error creating cart")
                }
            }
        }
    }
    
    
   
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailViewModel?.product.node.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        
        configureCell(cell, at: indexPath)
        if let productNode = productDetailViewModel?.product.node {
            print("Product Node: \(productNode.id)")
            cell.nameLabel.text = productNode.name
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            pageControl.numberOfPages = productNode.images.count
        }
        if let price = productDetailViewModel?.product.node.variants[indexPath.item].pricing.price.gross.amount {
            
            let priceString = String(price)
            cell.priceLabel.text = priceString
        }
        
        return cell
        
    }
    
    func configureCell(_ cell: ImageCell, at indexPath: IndexPath) {
        guard let image = productDetailViewModel?.product.node.images[indexPath.item],
              let imageURL = URL(string: image.url) else {
            return
        }
        cell.productImageViews.kf.setImage(with: imageURL)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
}


