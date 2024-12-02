
import UIKit

class ViewController: UIViewController {
         var firstNumber = ""
         var operation = ""
         var secondNumber = ""
  
    @IBOutlet weak var label: UILabel!
    
    
    
    
    @IBAction func numberbuttonPress(_ sender: UIButton) {
        
        if operation.isEmpty {
                   firstNumber += String(sender.tag)
                   label.text = firstNumber
               } else {
                   secondNumber += String(sender.tag)
                   label.text = secondNumber
               }
    }

    @IBAction func operationButtonPress(_ sender: Any) {
        
        if firstNumber.isEmpty { return }
               
        operation = (sender as AnyObject).titleLabel?.text ?? ""
        
         }
    
    @IBAction func equals(_ sender: UIButton) {
        if let first = Double(firstNumber), let second = Double(secondNumber) {
            switch operation {
            case "+": label.text = "\(first + second)"
            case "-": label.text = "\(first - second)"
            case "*": label.text = "\(first * second)"
            case "/":label.text = "\(first / second)"
            default: break
            }
        }
        firstNumber = label.text ?? ""
        secondNumber = ""
        operation = ""
    }
    
    
    
    @IBAction func clear(_ sender: Any) {
        
        firstNumber = ""
        operation = ""
        secondNumber = ""
        label.text = "0"
    }
}
    

