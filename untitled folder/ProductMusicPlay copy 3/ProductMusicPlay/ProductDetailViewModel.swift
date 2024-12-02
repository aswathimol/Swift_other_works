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
    
    
}



