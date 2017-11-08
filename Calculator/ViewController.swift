//
//  ViewController.swift
//  Calculator
//
//  Created by Joe Frederick Samuel on 2017-10-01.
//  Copyright © 2017 Joe Frederick Samuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Optionals are automatcially initialiised with null
    @IBOutlet weak var display: UILabel!
    
    //Automatically infered by the compiler to be Boolean
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display!.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    //Computed property
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
        brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
        
    }
    
    
}

