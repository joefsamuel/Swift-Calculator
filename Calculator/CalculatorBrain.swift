//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Joe Frederick Samuel on 2017-10-02.
//  Copyright © 2017 Joe Frederick Samuel. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    private var accumulator: Double?
    
    private enum Operations{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operations> =
        [
            "π" : Operations.constant(Double.pi),
            "e" : Operations.constant(M_E),
            "√" : Operations.unaryOperation(sqrt),
            "cos" : Operations.unaryOperation(cos),
            "±" : Operations.unaryOperation({-$0}),
            "x" : Operations.binaryOperation({$0 * $1}),
            "÷" : Operations.binaryOperation({$0 / $1}),
            "+" : Operations.binaryOperation({$0 + $1}),
            "-" : Operations.binaryOperation({$0 - $1}),
            "=" : Operations.equals
    ]
    
    mutating func performOperation(_ mathematicalSymbol: String){
        if let constant = operations[mathematicalSymbol]{
            switch constant{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != 0 {
                    accumulator = function(accumulator!)
                    }
            case .binaryOperation(let function):
                if accumulator != nil{
                pendingBinaryOperation = PendingBinaryOperation(function: function, firstOp: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        accumulator = pendingBinaryOperation?.perform(with: accumulator!)
        pendingBinaryOperation = nil
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function: (Double, Double) -> Double
        let firstOp: Double
        
        func perform(with secondOp: Double) -> Double{
            return function(firstOp, secondOp)
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double?{
        get{
            return accumulator
        }
    }
}
