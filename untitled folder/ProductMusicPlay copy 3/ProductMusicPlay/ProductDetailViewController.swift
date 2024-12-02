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
        
        print("Before creating cart")
        guard let currentProductID = getCurrentVariantID() else {
            print("Error getting current product ID")
            return
        }
        if let currentToken = ProductCategoryDetails.getCheckoutToken() {
            addToCart(checkoutToken: currentToken)
        }
        else {
            
            ProductCategoryDetails.createCart { [weak self] checkoutToken in
                guard let self = self else { return }
                print("Inside createCart: \(checkoutToken) ")
                
                if let checkoutToken = checkoutToken {
                    print("Checkout token received: \(checkoutToken)")
                    
                    ProductCategoryDetails.addToCart(checkoutToken: checkoutToken, productID: currentProductID) { success in
                        if success {
                            
                            print("Added to cart successfully")
                            
                            
                        }
                    }
                }
                else {
                    print("Error creating cart")
                }
            }
        }
    }
    
    func addToCart(checkoutToken: String) {
        guard let currentProductID = getCurrentVariantID() else {
            print("Error getting current product ID")
            return
        }
        
        ProductCategoryDetails.addToCart(checkoutToken: checkoutToken, productID: currentProductID) { success in
            if success {
                print("Added to cart successfully")
            }
        }
    }
    func getCurrentVariantID() -> String? {
        guard let currentProduct = productDetailViewModel?.product.node.variants.first
        else {
            print("Error: currentProduct or selectedProductIndex is nil")
            return nil
        }
        print("Current product variants: \(currentProduct)")
        return currentProduct.id
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let productNode = productDetailViewModel?.product.node {
            print("Product Node: \(productNode.id)")
            self.nameLabel.text = productNode.name
            nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            self.recordLabel.text = productDetailViewModel?.recordLabel
            
            pageControl.numberOfPages = productNode.images.count
        }
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


