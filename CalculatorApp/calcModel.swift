//
//  calcModel.swift
//  CalculatorApp
//
//  Created by Daulet Ashikbayev on 11.02.2022.
//

import Foundation
enum Operation{
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double, Double)->Double)
    case equals
}

struct CalcModel{
    var my_operation: Dictionary<String,Operation> =
    [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "+": Operation.binaryOperation({$0+$1}),
        "-": Operation.binaryOperation({$0-$1}),
        "*": Operation.binaryOperation({$0*$1}),
        "/": Operation.binaryOperation({$0/$1}),
        "=": Operation.equals
    ]
    private var global_value: Double?
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    mutating func performOperation(_ operation: String){
        let symbol = my_operation[operation]!
        switch symbol {
        case .constant(let value):
            global_value = value
            
        case .unaryOperation(let function):
            global_value = function(global_value!)
            
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOpperation(firstOperand: global_value!, operation: function)
        case .equals:
            global_value = saving?.performOperationWith(secondOperand: global_value!)
        }
    }
    func getResult()-> Double?{
        return global_value
    }
    private var saving: SaveFirstOperandAndOpperation?
    struct SaveFirstOperandAndOpperation {
        var firstOperand: Double
        var operation: (Double, Double) -> Double
        
        func performOperationWith(secondOperand op2: Double) -> Double {
            return operation(firstOperand, op2)
        }
    }
}
