
import UIKit

class ViewController: UIViewController {
    
    
    var firstNumber: String = ""
    var operation: String = ""
    var secondNumber: String = ""
    var haveResult: Bool = false
    var resultNumber: String = ""
    var numAfterResult: String = ""
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet var CalcButtons: [UIButton]! {
        didSet {
            for button in CalcButtons {
                button.layer.cornerRadius = button.frame.size.height/2 ;
            }
        }
    }
    @IBAction func numPressed(_ sender: UIButton) {
        
        if operation == ""
        {
            firstNumber += String(sender.tag)
            label.text = firstNumber;
        }
        else if operation != "" && !haveResult {
            secondNumber += String(sender.tag)
            label.text = secondNumber;
        }
        else if operation != "" && haveResult {
            numAfterResult += String(sender.tag)
            label.text = numAfterResult
        }
    }

    @IBAction func add(_ sender: UIButton) {
        operation = "+"
    }
    
    
    @IBAction func Subtract(_ sender: UIButton) {
        operation = "-"
    }
    
    
    @IBAction func mult(_ sender: UIButton) {
        operation = "*"
    }
    
    
    @IBAction func division(_ sender: Any) {
        operation = "/"
    }
    
    @IBAction func equals(_ sender: Any) {
        resultNumber = String(doOperation())
        label.text = resultNumber;
        numAfterResult = "";
    }
    
    @IBAction func clear(_ sender: Any) {
        firstNumber = ""
        operation = ""
        secondNumber = ""
        haveResult = false
        resultNumber = ""
        numAfterResult = ""
        label.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func doOperation() -> Double {
        switch operation {
        case "+":
            if !haveResult {
                haveResult = true;
                return Double(firstNumber)! + Double(secondNumber)!
            }
            else{
                return Double(resultNumber)! + Double(numAfterResult)!
            }
        case "-":
            if !haveResult{
                haveResult = true;
                return Double(firstNumber)! - Double (secondNumber)!
            }
            else {
                return Double(resultNumber)! - Double(numAfterResult)!
            }
        case "*":
            if !haveResult{
                haveResult = true;
                return Double(firstNumber)! * Double (secondNumber)!
            }
            else {
                return Double(resultNumber)! * Double(numAfterResult)!
            }
        case "/":
            if !haveResult{
                haveResult = true;
                return Double(firstNumber)! / Double (secondNumber)!
            }
            else {
                return Double(resultNumber)! / Double(numAfterResult)!
            }
            
        default:
            break
        }
            return 0;
        }
        
    }
    

