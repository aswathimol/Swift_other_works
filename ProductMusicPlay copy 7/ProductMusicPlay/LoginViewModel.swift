//
//  EntryViewModel.swift
//  ProductMusicPlay
//
//  Created by Aswathimol S(UST,IN) on 01/12/23.
//

import Foundation
import UIKit

class LoginViewModel {
    
     func isValidPassword(_ password: String) -> Bool {
        
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
        
    }
    
}
