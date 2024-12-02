//
//  ViewController.swift
//  Delegation
//
//  Created by Aswathimol S(UST,IN) on 30/10/23.
//

import UIKit

class ViewController: UIViewController, SomeProtocol {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func didSelect(value: String) {
        label.text = value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController {
            destination.delegate = self
        }
    }

}

