//
//  CartViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 22/11/23.
//

import Foundation
import UIKit


class CartViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedVariant: Variants?
    
    
    @IBOutlet  weak var cartView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as? CartViewCell else {
            fatalError()
        }
        
        if let variant = selectedVariant {
            cell.cartItemLabel.text = variant.name
        }
        
        return cell
    }
    
}
