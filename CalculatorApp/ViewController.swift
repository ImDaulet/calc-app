//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Daulet Ashikbayev on 10.02.2022.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var myDisplay: UILabel!
    var typing: Bool = false
    @IBAction func digitPressed(_ sender: UIButton) {
        let current_digit = sender.currentTitle!
        if typing {
            let current_display = myDisplay.text!
            myDisplay.text = current_display + current_digit
        } else {
            myDisplay.text = current_digit
            typing = true
        }
    }
    var displayValue: Double{
        get{
            return Double(myDisplay.text!)!
        }
        set{
            myDisplay.text = String(newValue)
        }
    }
    private var calculatorModel = CalcModel()
    @IBAction func operationPressed(_ sender: UIButton) {
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue = calculatorModel.getResult()!
        
        typing = false
    }
    
}

