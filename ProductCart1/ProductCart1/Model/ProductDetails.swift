//
//  productDetails.swift
//  ProductCart1
//
//  Created by Aswathimol S(UST,IN) on 18/10/23.
//

import Foundation
import SwiftUI


struct ProductDetails {
    
    static func getProducts(completion: @escaping([Product]) -> Void){
        guard let url = URL(string: "https://fakestoreapi.com/products/")
        else{
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            print(String(data: data!, encoding: .utf8))
            do{
                let details = try JSONDecoder().decode([Product].self, from: data!)
                completion(details)
            }
            catch{
                print(error)
            }
        }.resume()
    }
    
    
    
}
