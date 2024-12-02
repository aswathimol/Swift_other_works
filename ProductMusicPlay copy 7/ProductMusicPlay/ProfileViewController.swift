//
//  ProfileViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 08/01/24.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    
    
    @IBOutlet var userImageView: UIImageView!
    
    
    @IBOutlet var userNameLabel: UILabel!
    
    
   
    
    @IBOutlet var userEmailLabel: UILabel!
    
   
   
    
    @IBOutlet var logOut: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.title = "PROFILE"
        self.userNameLabel.text = "Jack Will"
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.userEmailLabel.text = "Jack@1234567"
        self.userEmailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }
    
    @IBAction func logOutButtonTapped() {
        self.navigationController?.tabBarController?.navigationController?.popViewController(animated: true)
    }
   
    
}
