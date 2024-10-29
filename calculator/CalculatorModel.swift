//
//  CalculatorModel.swift
//  calculator
//
//  Created by Nassor, Hamad on 10/10/2024.
//

import Foundation

enum OperationType {
    case multiplication, subtraction, addition, none
    
    var textValue: String {
        switch self {
        case .addition: return "Addition"
        case .subtraction: return "Subtraction"
        case .multiplication: return "Multiplication"
        case .none: return "None"
        }
    }
}

class CalculatorModel: ObservableObject {
    weak var calculatorModelDelegate: CalculatorModelDelegate?
    weak var calculatorModelInternalDisplayDelegate: CalculatorModelInternalDisplayDelegate?

    var storedValue: [Int] {
        didSet {calculatorModelInternalDisplayDelegate?.didUpdateStoredValue(storedValue)}
    }
    var displayedValue: [Int] {
        didSet {calculatorModelInternalDisplayDelegate?.didUpdateDisplayedValue(displayedValue)}
    }
    
    var maxNumberOfDigits: Int = 9
    
    var isError = false {
        didSet {calculatorModelInternalDisplayDelegate?.didUpdateIsError(isError)}
    }
    
    var currentOperation: OperationType = .none {
        didSet {calculatorModelInternalDisplayDelegate?.didUpdateOperation(currentOperation)}
    }
    
    init() {
        storedValue = Array(repeating: 0, count: maxNumberOfDigits)
        displayedValue = Array(repeating: 0, count: maxNumberOfDigits)
    }
    
    func enterNumber(_ number: Int) {
        if displayedValue.first != 0 {
            self.resetValues()
            isError = true
        } else{
            displayedValue.removeFirst()
            displayedValue.append(number)
        }
        
        calculatorModelDelegate?.didUpdateDisplay(displayedValue: convertArrayToInt(displayedValue), error: isError)
    }
    
    func setDisplayInput(number: Int){
        let numberArray = String(number).compactMap { Int(String($0)) }
        if numberArray.count > maxNumberOfDigits {
            resetValues()
            isError = true
        } else {
            displayedValue = Array(repeating: 0, count: maxNumberOfDigits - numberArray.count) + numberArray
        }
        calculatorModelDelegate?.didUpdateDisplay(displayedValue: convertArrayToInt(displayedValue), error: isError)
    }
    
    func setOperation(operation: OperationType) {
        if currentOperation != .none {
            performEquals()
        }

        currentOperation = operation
        storedValue = displayedValue
        displayedValue = Array(repeating: 0, count: maxNumberOfDigits)

        calculatorModelDelegate?.didUpdateDisplay(displayedValue: convertArrayToInt(storedValue), error: isError)
        isError = false
    }
    
    func performEquals() {
        switch currentOperation {
            case .multiplication:
                self.setDisplayInput(number: convertArrayToInt(storedValue) * convertArrayToInt(displayedValue))
            case .subtraction:
                self.setDisplayInput(number:  convertArrayToInt(storedValue) - convertArrayToInt(displayedValue))
            case .addition:
                self.setDisplayInput(number:  convertArrayToInt(storedValue) + convertArrayToInt(displayedValue))
            case .none:
                break
        }

        currentOperation = .none
    }
    
    func convertArrayToInt(_ array: [Int]) -> Int {
        var result = 0
        var multipler = 1
        
        for index in stride(from: array.count - 1, through: 0, by: -1) {
            let digit = array[index]
            result = result + (multipler * digit)
            multipler *= 10
        }
        
        return result
    }
    
    func clear() {
        self.resetValues()
        calculatorModelDelegate?.didUpdateDisplay(displayedValue: 0, error: isError)
    }
    
    func resetValues(){
        displayedValue = Array(repeating: 0, count: maxNumberOfDigits)
        storedValue = Array(repeating: 0, count: maxNumberOfDigits)
        currentOperation = .none
        isError = false
    }
}

protocol CalculatorModelDelegate: AnyObject {
    func didUpdateDisplay(displayedValue: Int, error: Bool)
}

protocol CalculatorModelInternalDisplayDelegate: AnyObject{
    func didUpdateStoredValue(_ value: [Int])
    func didUpdateDisplayedValue(_ value: [Int])
    func didUpdateIsError(_ isError: Bool)
    func didUpdateOperation(_ operation: OperationType)
}
