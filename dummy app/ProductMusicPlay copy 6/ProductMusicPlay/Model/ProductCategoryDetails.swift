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
    
    
    static func saveCheckoutToken(token: String) {
            UserDefaults.standard.set(token, forKey: "CheckoutToken")
    }

    static func getCheckoutToken() -> String? {
            return UserDefaults.standard.string(forKey: "CheckoutToken")
    }
    static func createCartIfNeeded(completion: @escaping (String?) -> Void) {
        if let checkoutToken = getCheckoutToken() {
            completion(checkoutToken)
        }
//        else {
//
//            createCart { token in
//                if let token = token {
//                    saveCheckoutToken(token: token)
//                    completion(token)
//                } else {
//                    completion(nil)
//                }
//            }
//        }
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
                           saveCheckoutToken(token: token)
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
    
    
    static func addToCart(checkoutToken: String, productID: String, completion: @escaping (Bool) -> Void) {
        
        let addtocartQuery = String(format: #"{"query": "mutation { checkoutLinesAdd(token: \"%@\", lines: [{ quantity: 1, variantId: \"%@\"}]) { checkout { id } errors { message } } }"}"#, checkoutToken, productID)
        
        
        let addToCartURLString = "https://store-bbte8otr.saleor.cloud/graphql/"
        
        guard let url = URL(string: addToCartURLString) else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = addtocartQuery.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                  
                    if let jsonDict = json as? [String: Any],
                       let checkoutData = jsonDict["checkoutLinesAdd"] as? [String: Any],
                       let errors = checkoutData["errors"] as? [[String: Any]],
                       let errorMessage = errors.first?["message"] as? String {
                        print("Error adding to cart: \(errorMessage)")
                        completion(false)
                    } else {
                        print("Added  successfully")
                        completion(true)
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                    completion(false)
                }
            } else {
                print("Error with the data response")
                completion(false)
            }
        }
        
        task.resume()
        
    }
    
    static func getCartDetails(checkoutToken: String, completion: @escaping (CheckoutFetchResponse?) -> Void) {
        print("start")
        let cartDetailsQuery = String(format: #"{"query": "query CheckoutFetchByToken { checkout(token: \"%@\") { id email lines { id totalPrice { gross { amount currency } } variant { product { id name slug thumbnail { url alt } } pricing { price { gross { amount currency } } } name } quantity } totalPrice { gross { amount currency } tax { amount currency } net { amount currency } } } }"}"#, checkoutToken)
      
        
        guard let url = URL(string: "https://store-bbte8otr.saleor.cloud/graphql/") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = cartDetailsQuery.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    if let error = error {
                        print("Error fetching data: \(error)")
                    }
                    completion(nil)
                    return
                }
                let dataString = String(data: data, encoding: .utf8)
                print("Received data:\n\(dataString ?? "Unable to convert data to string")")
                do {
                    let cartDetails = try JSONDecoder().decode(CheckoutFetchResponse.self, from: data)
                    completion(cartDetails)
                } catch let decodingError {
                    print("Error decoding data: \(decodingError)")
                    completion(nil)
                }

            }
        }.resume()
    }
    

    static func deleteCartItem(checkoutToken: String, lineID: String, completion: @escaping (Result<DeleteCheckoutLineResponse, Error>) -> Void) {
        print("start to delete")
        
        let deleteQuery = String(format: #"{"query": "mutation CheckoutLineDelete{checkoutLineDelete(token: \"%@\", lineId: \"%@\"){checkout{token} errors {field, message}}}"}"#, checkoutToken,lineID)
        
        guard let url = URL(string: "https://store-bbte8otr.saleor.cloud/graphql/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = deleteQuery.data(using: .utf8)
        
        print("Request URL: \(url)")
        print("Request Body: \(deleteQuery)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            print(String(data: data, encoding: .utf8)!)
            print("haiii")
            do {
                let cartDetails = try JSONDecoder().decode(DeleteCheckoutLineResponse.self, from: data)
                print("Successfully decoded data")
                completion(.success(cartDetails))
            } catch {
                print("Error decoding data: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

}
