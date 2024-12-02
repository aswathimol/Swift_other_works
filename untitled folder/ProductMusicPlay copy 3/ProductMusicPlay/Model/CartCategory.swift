//
//  CartCategory.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 06/12/23.
//

import Foundation
import UIKit

struct CheckoutFetchResponse: Decodable {
    let data: CheckoutData
}

struct CheckoutData: Decodable {
    let checkout: Checkout
}

struct Checkout: Decodable {
    let id: String
    let email: String
    let lines: [CheckoutLine]
    let totalPrice: TotalPrice
}

struct CheckoutLine: Decodable {
    let id: String
    let totalPrice: TotalPrice
    let variant: CheckoutVariant
}

struct TotalPrice: Decodable {
    let gross: CartGross
}

struct CheckoutVariant: Decodable {
    let product: Product
    let pricing: Pricings
    let name: String
}

struct Product: Decodable {
    let id: String
    let name: String
    let slug: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Decodable {
    let url: String
    let alt: String
}

struct Pricings: Decodable {
    let price: CartPrice
}

struct CartPrice: Decodable {
    let gross: CartGross
}

struct CartGross: Decodable {
    let amount: Double
    let currency: String
}
