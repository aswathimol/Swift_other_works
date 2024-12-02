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
    
    @IBOutlet var footerView: UIView!
    
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    
    @IBOutlet var taxlabel: UILabel!
    
    
    @IBOutlet var netLabel: UILabel!
    
    
    @IBOutlet var checkoutButton: UIButton!
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private func showActivityIndicator() {
       // cartView.alpha = 0.0
        footerView.alpha = 0.0
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        UIView.animate(withDuration: 0.2) {
          //  self.cartView.alpha = 1.0
            self.footerView.alpha = 1.0
        }
        self.activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        cartView.dataSource = self
        cartView.delegate = self
        
        self.title = "CART"
     
        
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
        hideActivityIndicator()
        
       
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
     
            
        }
        
        if let productPrice = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].variant.pricing.price.gross.amount {
            let priceString = String(productPrice)
            cell.productInCartPrice.text = "$\(priceString)"
            cell.productInCartPrice.font = UIFont.boldSystemFont(ofSize: 15)
        }
        
        if let productPrice = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].quantity{
            let priceString = String(productPrice)
            cell.productInCartDescription.text = "Qty:\(priceString)"
            cell.productInCartDescription.font = UIFont.boldSystemFont(ofSize: 13)
        }
        
        if let image = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].variant.product.thumbnail,
           let imageURL = URL(string: image.url) {
            cell.productIncartImageView.kf.setImage(with: imageURL)
        }
        
           let deleteButton = UIButton(type: .system)
           deleteButton.setTitle("Delete", for: .normal)
           deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
           cell.accessoryView = deleteButton
        return cell
    }
    
   
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let indexPath = cartView.indexPath(for: sender.superview?.superview as! CartViewCell ) else{
            return
        }
       showActivityIndicator()
        let checkoutToken = cartViewModel?.checkoutToken
            let lineID = cartViewModel?.cartDetails?.data.checkout.lines[indexPath.row].id

            ProductCategoryDetails.deleteCartItem(checkoutToken: checkoutToken ?? "", lineID: lineID ?? "") { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    
                    self.cartViewModel?.fetchCartDetails()
                    DispatchQueue.main.async {
                      self.hideActivityIndicator()
                    }
                  
                    
                case .failure(let error):
                    print("Error deleting item: \(error)")
                }
            }
    }

    func updateTabBarCountAndTotalPrice() {
        self.navigationController?.tabBarItem.badgeValue = "\(cartViewModel?.cartDetails?.data.checkout.lines.count ?? 0)"
        
        if let totalPrice = cartViewModel?.cartDetails?.data.checkout.totalPrice {
            self.totalPriceLabel.text = "Item Total:   $\(String(totalPrice.gross.amount))"
            self.totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 17)
           self.taxlabel.text = "Tax: $\(String(totalPrice.tax?.amount ?? 0))"
            self.taxlabel.font = UIFont.boldSystemFont(ofSize: 17)
            self.netLabel.text = "Amount to Pay:   $\(String(totalPrice.net?.amount ?? 0))"
            self.netLabel.font = UIFont.boldSystemFont(ofSize: 17)
        } else {
            self.totalPriceLabel.text = "Default Value "
        }
        
    }
    
}



