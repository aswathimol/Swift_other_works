//
//  ProductDetailViewModel.swift
//  ProductCart1
//
//  Created by Aswathimol S(UST,IN) on 30/10/23.
//

import Foundation
import UIKit

class ProductDetailViewModel {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var categoryName: NSAttributedString {
        let categorys = "Category:"
        let modifiedCategory = NSMutableAttributedString(string: "\(categorys) \(product.category)")
        modifiedCategory.addAttributes([.font: UIFont.boldSystemFont(ofSize: 18.0)], range: NSRange(location: 0, length: categorys.count))
        return modifiedCategory
    }
    var producttitle: String {
        let titleName = product.title
        return titleName
    }
    var productprice: String {
        let priceString = String(product.price)
        return priceString
    }
    var productDescription: String {
        let productDescription = product.description
        return productDescription
    }
    
    var productCount: NSAttributedString {
        let counts = "Count:"
        let modifiedCount = NSMutableAttributedString(string: "\(counts) \(product.rating.count)")
        modifiedCount.addAttributes([.font: UIFont.boldSystemFont(ofSize: 18.0)], range: NSRange(location: 0, length: counts.count))
        return modifiedCount
        
    }
    
    var productRate: NSAttributedString {
        let rates = "Rate:"
        let modifiedRate = NSMutableAttributedString(string: "\(rates) \(product.rating.rate)")
        modifiedRate.addAttributes([.font: UIFont.boldSystemFont(ofSize: 18.0)], range: NSRange(location: 0, length: rates.count))
        return modifiedRate
        
    }
    
    func getProductImageURL() -> URL? {
            return URL(string: product.image)
    }
}








