//
//  ProductDetailListViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 20/11/23.
//

import Foundation
import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    var productDetailViewModel: ProductDetailViewModel?
  

    @IBOutlet var productScrollView: UIScrollView!
    
    @IBOutlet var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var recordLabel: UILabel!
    
    @IBOutlet var variantButton1: UIButton!
    
    @IBOutlet var variantButton2: UIButton!
    
    @IBOutlet var addToCart: UIButton!
    
    @IBOutlet var attributeLabel: UILabel!
    
    @IBOutlet var DetailAttributeslabel: UILabel!
    
    @IBOutlet var pageControl: UIPageControl!
    
    
    @IBAction func variantButton1Tapped(_ sender: UIButton) {
        productDetailViewModel?.variantButtonTapped(index: 0)
        productDetailViewModel?.updateAddToCartButtonState(addToCart: addToCart)
        productDetailViewModel?.highlightVariantButton(selectedButton: sender, variantButton1: variantButton1, variantButton2: variantButton2)
        
    }
    
    @IBAction func variantButton2Tapped(_ sender: UIButton) {
        productDetailViewModel?.variantButtonTapped(index: 1)
        productDetailViewModel?.updateAddToCartButtonState(addToCart: addToCart)
        productDetailViewModel?.highlightVariantButton(selectedButton: sender, variantButton1: variantButton1, variantButton2: variantButton2)
        
    }
    
    func HighlightVariantButton(selectedButton: UIButton) {
        productDetailViewModel?.highlightVariantButton(selectedButton: selectedButton, variantButton1: variantButton1, variantButton2: variantButton2)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        productDetailViewModel?.updateAddToCartButtonState(addToCart: addToCart)
        
        
        if let productNode = productDetailViewModel?.product.node {
            self.nameLabel.text = productNode.name
            nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            let formattedText = productDetailViewModel?.attributesText ?? ""
            self.DetailAttributeslabel.text = formattedText
            
            variantButton1.setTitle(productDetailViewModel?.variantButtonText(index: 0), for: .normal)
            variantButton2.setTitle(productDetailViewModel?.variantButtonText(index: 1), for: .normal)
            
            //HighlightVariantButton(selectedButton: selectedButton)
            
            self.recordLabel.text = productDetailViewModel?.recordLabel
            self.attributeLabel.text = productDetailViewModel?.AttributeLabel
            
            
            pageControl.numberOfPages = productNode.images.count
        }
    }
    
    
    //let productNode = product?.node
    
    //pageControl.numberOfPages = product?.node.images.count ?? 0
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailViewModel?.product.node.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        configureCell(cell, at: indexPath)
        return cell
        
    }
    
    func configureCell(_ cell: ImageCell, at indexPath: IndexPath) {
        guard let image = productDetailViewModel?.product.node.images[indexPath.item],
              let imageURL = URL(string: image.url) else {
            return
        }
        cell.productImageViews.kf.setImage(with: imageURL)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
    
}

