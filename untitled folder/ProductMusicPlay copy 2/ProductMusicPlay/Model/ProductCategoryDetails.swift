//    //
//    //  ProductCategoryDetails.swift
//    //  ProductMusicPlay
//    //
//    //  Created by Aswathimol S(UST,IN) on 06/11/23.
//    //
import Foundation
import SwiftUI

struct ProductCategoryDetails {
    static func getProducts(completion: @escaping([ProductEdge]) -> Void){
        
        
        let graphQlQuery = #"{"query": "{query: products(first: 100, channel: \"default-channel\") {edges {node {category {name id}id name images {url}variants {id name pricing {price {currency gross {amount currency}net{amount currency}tax {amount currency}}}}attributes {attribute {name}values {id name slug}}}}}}"}"#
        
        
        let urlString = "https://store-bbte8otr.saleor.cloud/graphql/"
        guard let url = URL(string: urlString) else {
            return
        }
        var urlRequest = URLRequest(url: url)
        // setting this urlRequest to post
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = graphQlQuery.data(using: .utf8)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            print(String(data: data, encoding: .utf8)!)
            do {
                let details = try JSONDecoder().decode(ProductCategory.self, from: data)
                completion(details.data.products.edges)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func createCart(completion: @escaping (String?) -> Void) {
        let cartCreationQuery = #"{"query":"mutation CheckoutCreate {checkoutCreate(input: {channel: \"default-channel\" email: \"customer@example.com\" lines: []}) {checkout {token} errors {field code}}}"}"#
        let cartCreationURLString = "https://store-bbte8otr.saleor.cloud/graphql/"
        
        guard let url = URL(string: cartCreationURLString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = cartCreationQuery.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    if let checkoutData = json?["data"] as? [String: Any],
                       let checkoutCreate = checkoutData["checkoutCreate"] as? [String: Any],
                       let checkoutToken = checkoutCreate["checkout"] as? [String: Any],
                       let token = checkoutToken["token"] as? String {
                        completion(token)
                        return
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
            
            completion(nil)
        }
        
        task.resume()
    }
    
    
    static func addToCart(checkoutToken: String) {
        
        let addtocartQUery = #"{"query": "mutation { checkoutLinesAdd(token: \"db7b358e-b9b9-42c3-b872-a6722166f3b0\", lines: [{ quantity: 1, variantId:\"UHJvZHVjdFZhcmlhbnQ6MzQ4\" }]) { checkout { id } errors { field message } } }"}""#
        let addToCartURLString = "https://store-bbte8otr.saleor.cloud/graphql/"
        guard let url = URL(string: addToCartURLString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let checkoutID = json["checkout"] as? [String: Any],
               let _ = checkoutID["id"] as? String {
                
                print("Added to cart successfully")
            } else {
                
                print("Error adding to cart")
            }
        }
        
        task.resume()
    }
    
    
}
