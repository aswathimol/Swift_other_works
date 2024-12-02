//
//  DataService.swift
//  Parsing
//
//  Created by Aswathimol S(UST,IN) on 10/10/23.
//

import Foundation
import UIKit


struct DataService {
    
    static func getUsers(completion: @escaping([User]) -> Void){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/")
        else{
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            print(String(data: data!, encoding: .utf8))
            do{
                let details = try JSONDecoder().decode([User].self, from: data!)
                completion(details)
            }
            catch {
                print(error)
            }
        }.resume()
        
    }
    
    
    
    
    
    
}
