//
//  ViewController.swift
//  Parsing
//
//  Created by Aswathimol S(UST,IN) on 09/10/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .black
        self.title = "USER DETAILS"
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        DataService.getUsers {[weak self] users in
            print(users)
            self?.users = users
            DispatchQueue.main.async {
                self?.tableView.backgroundView = nil
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? Cell
        else { fatalError() }
        cell.labelView.text =  "NAME  :  \( users[indexPath.row].name)"
        cell.selectionStyle = .none
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "USERS"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(users[indexPath.row])
        performSegue(withIdentifier: "showDetailsSegue", sender: users[indexPath.row])
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let detailsOfUser = sender as? User,
           let destination = segue.destination as? TableViewController {
            destination.detailsOfUser = detailsOfUser
        }
        
    }
 
}






