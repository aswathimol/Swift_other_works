//
//  ProductDetailViewController.swift
//  ProductCart1
//
//  Created by Aswathimol S(UST,IN) on 25/10/23.
//

import UIKit

class ProductDetailViewController: UIViewController , UIScrollViewDelegate {
    
    
    
    @IBOutlet var cartImageButton: UIButton!
    
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var cartButton: UIButton!
    
    @IBOutlet var productScrollView: UIScrollView!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var countLabel: UILabel!
    
    var productDetailViewModel: ProductDetailViewModel?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryLabel.attributedText = productDetailViewModel?.categoryName
        
        self.titleLabel.text = productDetailViewModel?.producttitle
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        
        if let price = productDetailViewModel?.productprice {
            self.priceLabel.text = "$ \(price) ea"
        } else {
            self.priceLabel.text = "Price not available"
        }
        
        self.priceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        
        self.countLabel.attributedText = productDetailViewModel?.productCount
        
        
        self.descriptionLabel.text = productDetailViewModel?.productDescription
        
        self.rateLabel.attributedText = productDetailViewModel?.productRate
        
        if let imageURL = productDetailViewModel?.getProductImageURL() {
            self.productImageView.kf.setImage(with: imageURL)
        }
        
        
    }
    
}


