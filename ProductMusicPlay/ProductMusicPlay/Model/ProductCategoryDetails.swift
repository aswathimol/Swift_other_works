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
       
       
        
        let graphQlQuery = "{\"query\": \"{products(first: 100,channel: \\\"default-channel\\\"where: {category: {eq: \\\"Q2F0ZWdvcnk6NDU=\\\"}}){edges {node {category {name,id}id,name,images {url}variants {id,name,pricing {price {currency,gross {amount,currency}net {amount,currency}tax {amount,currency}}}}attributes {attribute {name}values {id,name,slug}}}}}}\"}"

        let urlString = "https://demo.saleor.io/graphql"
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
}
