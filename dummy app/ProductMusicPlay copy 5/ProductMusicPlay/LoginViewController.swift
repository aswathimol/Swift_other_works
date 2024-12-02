//
//  EntryViewController.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 30/11/23.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    var entryViewModel = LoginViewModel()
    
    @IBOutlet weak var entryView: UIView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var enterEmailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        
        enterEmailLabel.text = "Enter Your Email Id:"
        passwordLabel.text = "Enter Your Password:"
        
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
        
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        eyeButton.isSelected = !passwordTextField.isSecureTextEntry
    }
    
    
    @IBAction func loginButtonTapped() {
        guard let password = passwordTextField.text, !password.isEmpty,
              let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Email or password cannot be empty")
            return
        }
        
        let isValidPassword = entryViewModel.isValidPassword(password)
        let isValidEmail = entryViewModel.isValidEmail(email)
        
        if isValidPassword && isValidEmail {
            performSegue(withIdentifier: "homeTabSegue", sender: nil)
        } else {
            showAlert(message: "Invalid password or email. Please enter valid credentials.")
        }
        
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


