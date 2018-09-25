//
//  ViewController.swift
//  Calculator
//
//  Created by Richard Young on 9/24/18.
//  Copyright © 2018 Richard Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = Display.text!
            Display.text = textCurrentlyInDisplay + digit
        } else {
            Display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(Display.text!)!
        }
        set {
            Display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
//            switch mathematicalSymbol {
//            case "π":
//                displayValue = Double.pi
//            case "√":
//                displayValue = sqrt(displayValue)
//            default:
//                break
//            }
            if let result = brain.result {
                displayValue = result
            }
        }
    }
}

