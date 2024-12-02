//
//  ProductCategory.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 06/11/23.
//
import Foundation
import UIKit

struct ProductCategory: Decodable {
    let data: ProductsData
}

struct ProductsData: Decodable {
    let products: Products
}

struct Products: Decodable {
    let edges: [ProductEdge]
}

struct ProductEdge: Decodable {
    let node: ProductNode
}

struct ProductNode: Decodable {
    let category: Category
    let id: String
    let name: String
    let images: [Image]
    let variants: [Variants]
    let attributes: [Attributes]
   
}

struct Category: Decodable {
    let name: String
    let id: String
}

struct Image: Decodable {
    let url: String
    
}
struct Variants: Decodable {
    let id: String
    let name: String
    let pricing : Pricing
}
struct Pricing: Decodable{
    let price: Price
    
}
struct Price: Decodable {
    let currency: String
    let gross: Gross
    let net: Net
    let tax: Tax
}
struct Gross: Decodable {
    let amount: Double
    let currency: String
}
struct Net: Decodable {
    let amount: Double
    let currency: String
}
struct Tax: Decodable {
    let amount : Double
    let currency: String
    
}
struct Attributes: Decodable {
    
    let attribute: Attribute
    let values : [Values]
    
    
}
struct Attribute: Decodable{
    let name: String
   
}
struct Values: Decodable {
    
    let id: String
    let name: String
    let slug: String
    
    
}
