//
//  CartViewModel.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 04/12/23.
//

import Foundation
import UIKit

class CartViewModel {
    
    var checkoutToken: String?
    var cartDetails: CheckoutFetchResponse?
    weak var delegate: CartViewModelAction?
    
    func createCartIfNeededAndFetchDetails() {
            ProductCategoryDetails.createCartIfNeeded { [weak self] checkoutToken in
                if let checkoutToken = checkoutToken {
                    self?.checkoutToken = checkoutToken
                    print("Checkout Token: \(checkoutToken)")
                    self?.fetchCartDetails()
                }
            }
        }
    func fetchCartDetails() {
            guard let checkoutToken = checkoutToken else {
                print("Checkout token is nil.")
                return
            }
            
            ProductCategoryDetails.getCartDetails(checkoutToken: checkoutToken) { [weak self] cartDetails in
                DispatchQueue.main.async {
                    if let cartDetails = cartDetails {
                        print("Cart details fetched successfully.")
                        self?.cartDetails = cartDetails
                        self?.delegate?.finish()
                    } else {
                        print("Error fetching cart details.")
                    }
                }
            }
        }
    func getCartCount() -> Int {
            return cartDetails?.data.checkout.lines.count ?? 1
        }
    
}
