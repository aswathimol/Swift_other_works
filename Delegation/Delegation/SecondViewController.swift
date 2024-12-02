//
//  SecondViewController.swift
//  Delegation
//
//  Created by Aswathimol S(UST,IN) on 30/10/23.
//

import UIKit

class SecondViewController: UIViewController {

    weak var delegate: SomeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction() {
        delegate?.didSelect(value: "\(Int.random(in: 0...100))")
        self.dismiss(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
