import Foundation
import UIKit

struct CalculationLogic {
    
    private var number1: Double = 0
    
    mutating func setNumber(_ number1:Double) {
        self.number1 = number1
         print("this is number1 \(number1)")
    }
    
    private var number2: Double = 0
    
    mutating func setNumber2 (_ number2:Double) {
        self.number2 = number2
        print("this is number2 \(number2)")
    }
   
    private var tempNum:Double? //continous excution
    
    mutating func setTempNum(_ tempNum:Double){
        self.tempNum = tempNum
    }
    
    private var tempSymbol: String?
    
    mutating func setTempSymbol(_ tempSymbol:String) {
        self.tempSymbol = tempSymbol
    }
    
    private var intermediateCalculation : (n1:Double, calcMethod: String)? //tuple
    
    var numButtonPressed: Bool = false
    
    var calButtonPressedBefore: Bool = false
    
    
    
    mutating func calculate(symbol: String) -> Double? {
      //  if let num1 = number1, let num2 = number2 {
            switch symbol {
            case "+/-":
                
                return number1 * -1
                
            case "AC":
                print("This is AC")
                tempSymbol = nil
                number1 = 0
                number2 = 0
                tempNum = 0
                numButtonPressed = false
                calButtonPressedBefore = false

                return 0
            case "%":
                return number1 * 0.01
            case "=":
                
                return performTwoNumCalculation(n2: number2)
                
            default:
                intermediateCalculation = (n1: number1, calcMethod: symbol)
            }
        //}
        return nil
    }
    

    
    private mutating func performTwoNumCalculation(n2: Double = 0.0) -> Double? {
        if var n1:Double = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            
            if calButtonPressedBefore == true {
                if let temp = tempNum   {
                    print("this is temp \(temp)")
                    n1 = temp
                }
            }
            
            print("this is calcMethod \(operation)")
            print("this is n1 from Perfom \(n1)")
            print("this is n2 \(n2)")
            
            switch operation {
            case "+":
                tempNum = n1 + n2
                return n1 + n2
            case "-":
                tempNum = n1 - n2
                return n1 - n2
            case "×":
                tempNum = n1 * n2
                return n1 * n2
            case "÷":
                tempNum = n1 / n2
                return n1 / n2
            default:
                print("this is operation \(operation)")
                
                fatalError("The operation passed in does not match any of cases")
            }
        }
        return  nil
    }
 
   mutating func reset() {
        calButtonPressedBefore = false
        numButtonPressed = false
        setTempNum(0)
        setNumber(0)
        setNumber2(0)
        setTempSymbol("")
        print("AC btn")    }
}
