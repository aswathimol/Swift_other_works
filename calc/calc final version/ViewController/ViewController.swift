
import UIKit

class ViewController: UIViewController {
         var numbers  = [String]()
         var operations = [String] ()
         var secondNumber = ""
  
    @IBOutlet weak var label: UILabel!
    
    
    
    
    @IBAction func numberbuttonPress(_ sender: UIButton) {
        
        label.text = label.text! + String(sender.tag)
    }

    @IBAction func operationButtonPress(_ sender: UIButton) {
        
        if let currentNumber = label.text {
                    numbers.append(currentNumber)
                    label.text = ""
                    operations.append(sender.titleLabel!.text!)
                }
        
         }
    
    @IBAction func equals(_ sender: UIButton) {
        if let currentNumber = label.text {
                    numbers.append(currentNumber)
                }

                var result = Double(numbers[0]) ?? 0.0
                var currentOperationIndex = 0

                for (index, number) in numbers.enumerated() {
                    if index != 0 {
                        let operation = operations[currentOperationIndex]
                        currentOperationIndex += 1

                        if let num = Double(number) {
                            switch operation {
                            case "+":
                                result += num
                            case "-":
                                result -= num
                            case "*":
                                result *= num
                            case "/":
                                if num != 0 {
                                    result /= num
                                } else {
                                    label.text = "Not a number"
                                    return
                                }
                            default:
                                break
                            }
                        }
                    }
                }
        label.text = String(result)
                numbers.removeAll()
                operations.removeAll()
    }
    
    
    
    @IBAction func clear(_ sender: Any) {
        
        label.text = "0"
               numbers.removeAll()
               operations.removeAll()
           }
}
    

