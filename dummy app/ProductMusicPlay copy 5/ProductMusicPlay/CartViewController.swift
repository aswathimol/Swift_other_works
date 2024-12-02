//
//  CartViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 22/11/23.
//

import Foundation
import UIKit


class CartViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, CartViewModelAction  {
    
    var cartViewModel: CartViewModel?
    
    
    @IBOutlet var cartView: UITableView!
    
    @IBOutlet var viewInsideCartView: UIView!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    let productQuantity : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartView.dataSource = self
        cartView.delegate = self
        
        cartViewModel = CartViewModel()
        cartViewModel?.delegate = self
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel?.createCartIfNeededAndFetchDetails()
        
    }
    
    
    func finish() {
        
       
        self.cartView.reloadData()
        self.updateTabBarCountAndTotalPrice()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let heading = "Your Cart Items"
        return heading
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel?.cartDetails?.data.checkout.lines.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCellID", for: indexPath) as? CartViewCell else {
            fatalError("Unable to dequeue CartViewCell.")
        }
        
        
        if let product = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].variant.product {
            cell.productInCartLabel.text = product.name
            cell.productInCartLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
        }
        if let currentProductID = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].variant.product.id {
            cell.productInCartDescription.text = "asd"
            
        }
        
        
        if let productPrice = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].variant.pricing.price.gross.amount {
            let priceString = String(productPrice)
            cell.productInCartPrice.text = "$\(priceString)"
            cell.productInCartPrice.font = UIFont.boldSystemFont(ofSize: 15)
        }
        if let image = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].variant.product.thumbnail,
           let imageURL = URL(string: image.url) {
            cell.productIncartImageView.kf.setImage(with: imageURL)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteSymbol = "\u{1F5D1}\u{FE0E}"
        let deleteAction = UITableViewRowAction(style: .destructive, title: deleteSymbol) { [weak self] (_, indexPath) in
            guard let self = self else { return }
            
            let checkoutToken = self.cartViewModel?.checkoutToken
            let lineID = self.cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].id
            
            ProductCategoryDetails.deleteCartItem(checkoutToken: checkoutToken ?? "", lineID: lineID ?? "") { result in
                switch result {
                case .success(let response):
                    
                    self.cartViewModel?.fetchCartDetails()
                    
                    
                case .failure(let error):
                    print("Error deleting item: \(error)")
                }
            }
        }
        
        return [deleteAction]
    }
    
    
    func updateTabBarCountAndTotalPrice() {
        self.navigationController?.tabBarItem.badgeValue = "\(cartViewModel?.cartDetails?.data.checkout.lines.count ?? 0)"
        
        if let totalPrice = cartViewModel?.cartDetails?.data.checkout.totalPrice.gross.amount {
            self.totalPriceLabel.text = "Total Price: \(String(totalPrice))"
        } else {
            self.totalPriceLabel.text = "Default Value "
        }
    }
    
    
}



