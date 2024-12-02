//
//  ProductDetailListViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 20/11/23.
//

import Foundation
import UIKit

class ProductDetailListViewController: UIViewController, UIScrollViewDelegate {
    
    
    var product : ProductEdge?
    
    @IBOutlet var productScrollView: UIScrollView!
    
    
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    @IBOutlet var recordLabel: UILabel!
    
    
    @IBOutlet var variantButton1: UIButton!
    
    
    @IBOutlet var variantButton2: UIButton!
    
    
    @IBOutlet var addToCart: UIButton!
    
    @IBOutlet var attributeLabel: UILabel!
    
    
    @IBOutlet var DetailAttributeslabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let productNode = product?.node
        self.nameLabel.text = productNode?.name
        
        
        self.recordLabel.text = "Records"
        self.variantButton1.setTitle("\(productNode?.variants[0].name ?? "")\n$\(productNode?.variants[0].pricing.price.gross.amount ?? 0)", for: .normal)
        self.variantButton2.setTitle("\(productNode?.variants[1].name ?? "")\n$\(productNode?.variants[1].pricing.price.gross.amount ?? 0)", for: .normal)
        self.attributeLabel.text = "Attributes"
        
        self.DetailAttributeslabel.text = "Release Type:\(productNode?.attributes[0].values[0].name ?? "")\nArtist: \(productNode?.attributes[1].values[0].name ?? "")\nArtist Page: \(productNode?.attributes[2].values[0].name ?? "")\nGenre: \(productNode?.attributes[3].values[0].name ?? "")\nRelease Year: \(productNode?.attributes[4].values[0].name ?? "")\nLabel: \(productNode?.attributes[5].values[0].name ?? "")\nCountry: \(productNode?.attributes[6].values[0].name ?? "")"
        
   
    }
    
    
    
    
    
}
