//
//  ProductListViewModel.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 27/11/23.
//

import Foundation
import UIKit

class ProductListViewModel {
    
    weak var delegate: ProductListViewModelAction?
    
    var products: [ProductEdge] = []
    
    
    
    var productCount: Int {
        guard !products.isEmpty else{
            return 0
        }
        return products.count
    }
    func products(at index: Int) -> ProductEdge? {
        guard products.count > index else {
            return nil
        }
        return products[index]
    }
    func productDetailViewModel(at index: Int) -> ProductDetailViewModel? {
        guard products.count > index else {
            return nil
        }
        return ProductDetailViewModel(product: products[index])
    }

    func fetchProduct(){
        
        ProductCategoryDetails.getProducts { [weak self] productCategory in
            self?.products = productCategory
            DispatchQueue.main.async {
                self?.delegate?.didFinishFetchingProducts()
            }
        }
        
    }
}
