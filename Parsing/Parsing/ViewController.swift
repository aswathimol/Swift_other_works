//
//  ViewController.swift
//  Parsing
//
//  Created by Aswathimol S(UST,IN) on 09/10/23.
//

import UIKit


//"id": 1,
//"name": "Leanne Graham",
//"username": "Bret",
//"email": "Sincere@april.biz",
//"address": {
//  "street": "Kulas Light",
//  "suite": "Apt. 556",
//  "city": "Gwenborough",
//  "zipcode": "92998-3874",
//  "geo": {
//    "lat": "-37.3159",
//    "lng": "81.1496"
//  }
//},
//"phone": "1-770-736-8031 x56442",
//"website": "hildegard.org",
//"company": {
//  "name": "Romaguera-Crona",
//  "catchPhrase": "Multi-layered client-server neural-net",
//  "bs": "harness real-time e-markets"
//}
//}

struct Todo: Decodable {
    
    let id: Int
    let title: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case status = "completed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      //  self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        let isCompleted =  try container.decode(Bool.self, forKey: .status)
        self.status = isCompleted ? "Completed" : "InProgress"
    }
}

class ViewController: UIViewController {
//let users = [Todo]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        
        let tableView = UITableView()
        
        tableView.reloadData()
    }

    
    func getData() {
//    https://jsonplaceholder.typicode.com/todos/1
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/")
        else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(String(data: data!, encoding: .utf8))
            do {
                let todo = try JSONDecoder().decode(Todo.self, from: data!)
                print(todo)

            }
            catch {
                print(error)
            }
        }.resume()
    }

}

