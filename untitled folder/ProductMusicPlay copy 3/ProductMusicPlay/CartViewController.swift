//
//  CartViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 22/11/23.
//

import Foundation
import UIKit


class CartViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    var checkoutToken: String?
    var cartDetails: CheckoutFetchResponse?
    
  
    
    @IBOutlet var cartView: UITableView!
    
    
    
    func createCartIfNeededAndFetchDetails() {
            ProductCategoryDetails.createCartIfNeeded { [weak self] checkoutToken in
                if let checkoutToken = checkoutToken {
                    self?.checkoutToken = checkoutToken
                    print("Checkout Token: \(checkoutToken)")
                    self?.fetchCartDetails()
                }
            }
        }
    func fetchCartDetails() {
            guard let checkoutToken = checkoutToken else {
                print("Checkout token is nil.")
                return
            }
            
            ProductCategoryDetails.getCartDetails(checkoutToken: checkoutToken) { [weak self] cartDetails in
                DispatchQueue.main.async {
                    if let cartDetails = cartDetails {
                        print("Cart details fetched successfully.")
                        self?.cartDetails = cartDetails
                        self?.cartView.reloadData()
                    } else {
                        print("Error fetching cart details.")
                    }
                }
            }
        }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.dataSource = self
        cartView.delegate = self
        createCartIfNeededAndFetchDetails()
       
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDetails?.data.checkout.lines.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCellID", for: indexPath) as? CartViewCell else {
            fatalError("Unable to dequeue CartViewCell.")
        }
        
        
        if let product = cartDetails?.data.checkout.lines[indexPath.row].variant.product {
            cell.productInCartLabel.text = product.name
            cell.productInCartLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
        if let productPrice = cartDetails?.data.checkout.totalPrice.gross {
            let priceString = String(productPrice.amount)
            cell.productInCartPrice.text = "$\(priceString)"
            cell.productInCartPrice.font = UIFont.boldSystemFont(ofSize: 15)
        }

        if let image = cartDetails?.data.checkout.lines[indexPath.row].variant.product.thumbnail,
           let imageURL = URL(string: image.url) {
            
            cell.productIncartImageView.kf.setImage(with: imageURL)
        }
        return cell
    }
    
}



