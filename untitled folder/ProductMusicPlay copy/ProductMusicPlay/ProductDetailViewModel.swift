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
    
    var isVariantSelected: Bool {
        selectedVariant != nil
    }
    var selectedVariant: Variants?
    
   

    init(product: ProductEdge) {
        self.product = product
    }

    func variantButtonTapped(index: Int) {
        selectedVariant = product.node.variants[index]
    }
    
   
    func updateAddToCartButtonState(addToCart: UIButton) {
           addToCart.isEnabled = isVariantSelected
       }
    func highlightVariantButton(selectedButton: UIButton, variantButton1: UIButton, variantButton2: UIButton) {
        let unselectedColor = UIColor.systemBackground
        let selectedColor = UIColor.systemBlue
        
        variantButton1.backgroundColor = (selectedButton == variantButton1) ? selectedColor : unselectedColor
        variantButton2.backgroundColor = (selectedButton == variantButton2) ? selectedColor : unselectedColor
        selectedButton.backgroundColor = selectedColor
    }

    var attributesText: String {
        let product = product.node

        let releaseType = "Release type      \(product.attributes[0].values[0].name )"
            let artist = "Artist                   \(product.attributes[1].values[0].name )"
            let artistPage = "Artist Page         \(product.attributes[2].values[0].name )"
            let genre = "Genre                  \(product.attributes[3].values[0].name )"
            let releaseYear = "Release Year      \(product.attributes[4].values[0].name )"
            let label = "Label                   \(product.attributes[5].values[0].name )"
            let country = "Country               \(product.attributes[6].values[0].name )"

            return "\(releaseType)\n\(artist)\n\(artistPage)\n\(genre)\n\(releaseYear)\n\(label)\n\(country)"
        }
      func variantButtonText(index: Int) -> String {
          return "\(product.node.variants[index].name)\n$\(product.node.variants[index].pricing.price.gross.amount )"
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



