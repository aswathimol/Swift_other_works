//
//  CartViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 16/11/23.
//

import Foundation
import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var product : ProductEdge?
    
    
    @IBOutlet weak var cartView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cart Summary"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell" , for: indexPath) as? CartViewCell
        else{
            fatalError()
        }
        let cart = product?.node.variants[0].name
        cell.cartLabel.text = cart
        return cell
    }
    
    
    
    
    
    
}
