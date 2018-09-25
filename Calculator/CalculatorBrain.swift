//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Richard Young on 9/25/18.
//  Copyright © 2018 Richard Young. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}



struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
    [
    "π" : Operation.constant(Double.pi),
    "e" : Operation.constant(M_E),
    "√" : Operation.unaryOperation(sqrt),
    "cos" : Operation.unaryOperation(cos),
    "&" : Operation.unaryOperation(changeSign),
    "x" : Operation.binaryOperation({ $0 * $1}),
    "/" : Operation.binaryOperation({ $0 / $1}),
    "+" : Operation.binaryOperation({ $0 + $1}),
    "-" : Operation.binaryOperation({ $0 - $1}),
    "=" : Operation.equals
    ]
    
   mutating func performOperation(_ symbol: String) {
    if let operation = operations[symbol] {
        switch operation {
        case .constant(let value):
            accumulator = value
        case .unaryOperation:
            if accumulator != nil {
            accumulator = function(accumulator!)
            }
        case .binaryOperation(let function):
            pbo = PendingBinaryOperation(function: function, firstOperand: accumulator)
            if accumulator != nil {
                pbo = PendingBinaryOperation
                accumulator = nil
            }
        case.equals:
            performPendingBinaryOperation()
            }
    
        }
    }
    
    private func performPendingBinaryOperation(){
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with seconOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
