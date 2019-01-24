import UIKit

class ViewController: UIViewController {
  
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let currentValue = Double(displayLabel.text!) else {
                fatalError("Cannot convert display labeltext to a double ")
            }
            print("this is current value \(currentValue)")
            return currentValue
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        //What should happen when a non-number button is pressed
        //  sender.currentTitle
        if let calcMethod = sender.currentTitle {
            if calcMethod == "+/-" {
                //before using computed property
                //displayLabel.text = String(displayValue * -1)
                displayValue = displayValue * -1
            } else if  calcMethod == "AC"  {
                displayLabel.text = "0"
            } else if calcMethod == "%" {
                //before using computed property
                //displayLabel.text = String(displayValue / 100)
                displayValue = displayValue / 100
            }
        }
        print("This is displayValue  when calButtonPressed \(displayValue)")
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            if displayLabel.text == "0" && numValue == "."{//case of "."button pressed for first attempt
                displayLabel.text = "0."
                isFinishedTypingNumber = false
            }
            else if isFinishedTypingNumber == true { // case of any ohter numbers pressed
            
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            
            } else { // case of more than one numbers are pressed
                if let labelText = displayLabel.text {
                    if (!labelText.contains(".") || numValue != ".") {
                        
                        displayLabel.text = (displayLabel.text!) + numValue
                    }
                }
            }
            print("this is displayValue when numButtenPressed \(displayValue)")
        }

        //displayLabel.text = sender.currentTitle!
        //What should happen when a number is entered into the keypad
        
    }
    
}

