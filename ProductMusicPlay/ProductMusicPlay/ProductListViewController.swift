//
//  ViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 06/11/23.
//

import UIKit


class ProductListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var products: [ProductEdge] = []
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.blue
        ProductCategoryDetails.getProducts { [weak self] productCategory in
            self?.products = productCategory
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedproduct = products[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: selectedproduct)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destinationVC = segue.destination as? ProductDetailListViewController, let selectedproduct = sender as? ProductEdge {
                destinationVC.product = selectedproduct
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        
        cell.productNameLabel.text = product.node.name
        
        if let imageURLString = product.node.images.first?.url,
           let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    cell.productImageView.image = image
                }
            }.resume()
        }
        return cell
        
    }
    
    
}

