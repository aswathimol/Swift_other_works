//
//  ProductListViewModel.swift
//  ProductCart1
//
//  Created by Aswathimol S(UST,IN) on 27/10/23.
//

import Foundation
import UIKit

class ProductListViewModel {
    
    weak var delegate: ProductListViewModelActions?
    private var products: [Product] = []
    
    var productsCount: Int {
        guard !products.isEmpty else {
            return 0
        }
        return products.count
    }
    
    func product(at index: Int) -> Product? {
        guard products.count > index else {
            return nil
        }
        return products[index]
    }
    
    func selectProduct(at index: Int) -> ProductDetailViewModel? {
        guard products.count > index else {
            return nil
        }
        return ProductDetailViewModel(product: products[index])
    }
    
    func fetchProducts() {
        ProductDetails.getProducts { [weak self] products in
            self?.products = products
            DispatchQueue.main.async {
                self?.delegate?.didFinishFetchingProducts()
            }
        }
    }

}


