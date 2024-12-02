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
    // @IBOutlet var productView: UIView!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = product {
            
            let categorys = "Category:"
            let modifiedCategory = NSMutableAttributedString(string: "\(categorys) \(product.category)")
            modifiedCategory.addAttributes([.font: UIFont.boldSystemFont(ofSize: 18.0)], range: NSRange(location: 0, length: categorys.count))
            categoryLabel.attributedText = modifiedCategory
            
            
            
            titleLabel.text = "\(product.title)"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            
            let priceString = String(product.price)
            priceLabel.text = "$ \(priceString) ea"
            priceLabel.font =  UIFont.boldSystemFont(ofSize: 16.0)
            
            
            
            let counts = "Count:"
            let modifiedCount = NSMutableAttributedString(string: "\(counts) \(product.rating.count)")
            modifiedCount.addAttributes([.font: UIFont.boldSystemFont(ofSize: 18.0)], range: NSRange(location: 0, length: counts.count))
            countLabel.attributedText = modifiedCount
            
            
            
            descriptionLabel.text = product.description
            
            
            let rates = "Rate:"
            let modifiedRate = NSMutableAttributedString(string: "\(rates) \(product.rating.rate)")
            modifiedRate.addAttributes([.font: UIFont.boldSystemFont(ofSize: 18.0)], range: NSRange(location: 0, length: counts.count))
            rateLabel.attributedText = modifiedRate
            
            
            if let imageURL = URL(string: product.image) {
                productImageView.kf.setImage(with: imageURL)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//label.font = UIFont.boldSystemFont(ofSize: 16.0)



