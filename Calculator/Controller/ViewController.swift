import UIKit

class ViewController: UIViewController {
    
    private var calculator = CalculationLogic()
    
    private var isFinishedTypingNumber: Bool = true
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var displayValue: Double {
        get {
            guard let currentValue = Double(displayLabel.text!) else {
                fatalError("Cannot convert display labeltext to a double ")
            }
            return currentValue
        }
        set {
            if newValue == 0.0 {
                displayLabel.text = "0"
            }
                // not to have decimal point for Int value
            else if (newValue * 10).remainder(dividingBy: 10) == 0    {
                displayLabel.text = String(Int(newValue))
            }
            else {
                displayLabel.text = String(newValue)
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        print("numButtonPressed")
        calculator.numButtonPressed = true

        if let currentNumValue = sender.currentTitle {
            if displayLabel.text == "0" && currentNumValue == "."{//case of "."button pressed for first attempt
                displayLabel.text = "0."
                isFinishedTypingNumber = false
            }
                
            else if isFinishedTypingNumber == true { // case of any ohter numbers pressed
                displayLabel.text = currentNumValue
                isFinishedTypingNumber = false
                
            } else  { // case of more than one numbers are pressed
                
                if let labelText = displayLabel.text {
                    
                    if (!labelText.contains(".") || currentNumValue != ".") {
                        displayLabel.text = (displayLabel.text!) + currentNumValue
                        
                        // "ac" button bug
                        if labelText.first == "0" && !labelText.contains(".") {
                            // print("this is first element \(labelText.first)")
                            displayLabel.text = currentNumValue
                        }
                            // not to have "0" ahead of any numbers
                            
                        else if displayLabel.text == "0" && currentNumValue == "0"  {
                            displayLabel.text = currentNumValue
                        }
                    }
                }
            }
            
        }
        
        var doubleValue:Double = 0
        
        if let double = Double(displayLabel.text!)  {
            doubleValue = double
        }
        
        if  calculator.calButtonPressedBefore == false {
            calculator.setNumber(doubleValue)
            calculator.setTempNum(doubleValue)
            
        } else if calculator.calButtonPressedBefore == true {
            calculator.setNumber2(doubleValue)
        }
    }
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        calculator.calButtonPressedBefore = true
        print("CalButtonPressed")
        isFinishedTypingNumber = true
        
        if let tempSymbol = sender.currentTitle {
            calculator.setTempSymbol(tempSymbol)
        }
        
// when calcButton pressed without Num value
        if calculator.numButtonPressed == false
        {
            if sender.currentTitle == "+/-" {
                calculator.setTempSymbol("+/-")
                displayLabel.text = "-0"
            }
            else if   sender.currentTitle == "AC" {
                calculator.reset()
                displayLabel.text = "0"
            }
        } else {
//when calcButton pressed with Num value
            if let calcMethod = sender.currentTitle {
                
                if let result = calculator.calculate(symbol: calcMethod) {
                    displayValue = result
                    calculator.setTempNum(result)
                }
                
                if  sender.currentTitle == "AC" {
                    calculator.reset()
                    displayLabel.text = "0"
                }
            }
        }
        
    }
}

