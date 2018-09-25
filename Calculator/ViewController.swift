//
//  ViewController.swift
//  Calculator
//
//  Created by Richard Young on 9/24/18.
//  Copyright © 2018 Richard Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Display: UILabel?
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = Display!.text!
            Display!.text = textCurrentlyInDisplay + digit
        } else {
            Display!.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π":
                Display!.text = String(Double.pi)
            case "√":
                let operand = Double(Display!.text!)!
                Display!.text = String(sqrt(operand))
            default:
                break
            }
        }
    }
}

