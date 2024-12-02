//
//  ProductDetailViewModel.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 27/11/23.
//

import Foundation
import UIKit

class ProductDetailViewModel {
    
    let product: ProductEdge
    
    var selectedProductIndex: Int?
   
    
    init(product: ProductEdge) {
        self.product = product
    }
    
    
    var recordLabel: String {
        let recordString = "Records"
        return recordString
    }
    var AttributeLabel: String {
        let AttributeString = "Attributes"
        return AttributeString
    }
    
    func getCurrentVariantID() -> String? {
        guard let currentProduct = product.node.variants.first
        else {
            print("Error: currentProduct or selectedProductIndex is nil")
            return nil
        }
        print("Current product variants: \(currentProduct)")
        return currentProduct.id
    }
    
    func addToCart(checkoutToken: String) {
        guard let currentProductID = getCurrentVariantID() else {
            print("Error getting current product ID")
            return
        }
        
        ProductCategoryDetails.addToCart(checkoutToken: checkoutToken, productID: currentProductID) { success in
            if success {
               // showAlert(message: "Added to cart successfully")
                print("Added to cart successfully")
               
            }
        }
    }
    
}



