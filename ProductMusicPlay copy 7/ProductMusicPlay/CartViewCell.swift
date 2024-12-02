//
//  CartViewCell.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 22/11/23.
//

import Foundation
import UIKit

class CartViewCell: UITableViewCell {
    
    
   
    @IBOutlet var productInCartLabel: UILabel!
    
    @IBOutlet var productIncartImageView: UIImageView!
    
    @IBOutlet var productInCartPrice: UILabel!
    
    @IBOutlet var productInCartDescription: UILabel!
    
    @IBOutlet var deleteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
