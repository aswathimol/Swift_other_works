//
//  TableViewController.swift
//  Parsing
//
//  Created by Aswathimol S(UST,IN) on 11/10/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var detailsOfUser: User? = nil
    // var users: [User] = []
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet var comapnyLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var iconView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.black
        // tableView.selectionStyle = .none
        
        nameLabel.text = detailsOfUser?.name
        emailLabel.text = detailsOfUser?.email
        phoneLabel.text = detailsOfUser?.phone
        usernameLabel.text = detailsOfUser?.username
        websiteLabel.text = detailsOfUser?.website
        let addressDetails = detailsOfUser?.address
        
        let fullAddress = """
                    \(addressDetails?.street ?? "")
                    \(addressDetails?.suite ?? "")
                    \(addressDetails?.city ?? "")
                    \(addressDetails?.zipcode ?? "")
                """
        
        addressLabel.text = fullAddress
        let companyDetails = detailsOfUser?.company
        let fullDetailsOfCompany = """
                       \(companyDetails?.name ?? "")
                       \(companyDetails?.bs ?? "")
                       
               """
        comapnyLabel.text = fullDetailsOfCompany
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //tableView.allowsSelection == false
        
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 && indexPath.row == 6 {
            return indexPath
        } else {
            return nil
        }
    }
    
    //tableView.backgroundColor = .systemIndigo
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print(users[indexPath.row])
        if let user = detailsOfUser,
           indexPath.row == 6
        {
            performSegue(withIdentifier: "showDetailedSegue1", sender: user)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let detailsOfUser = sender as? User,
           let destination = segue.destination as?  ViewController1{
            destination.detailsOfUser1 = detailsOfUser
        }
        
    }
}
