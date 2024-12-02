//
//  cartDelete.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 28/12/23.
//

import Foundation
import UIKit

struct DeleteCheckoutLineResponse: Decodable {
    let data: DeleteCheckoutLineData?
    let errors: [MyError]?
}

struct DeleteCheckoutLineData: Decodable {
    let checkoutLineDelete: CheckoutLineDelete?
}

struct CheckoutLineDelete: Decodable {
    let checkout: RemoveCheckout?
    let errors: [MyError]?
}

struct RemoveCheckout: Decodable {
    let token: String?
}

struct MyError: Decodable {
    let field: String?
    let message: String?
}

