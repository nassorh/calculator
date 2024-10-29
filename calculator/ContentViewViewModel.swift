//
//  ContentViewViewModel.swift
//  calculator
//
//  Created by Nassor, Hamad on 11/10/2024.
//

import Foundation

class ContentViewModel: ObservableObject, CalculatorModelInternalDisplayDelegate {
    var calculatorModel: CalculatorModel
    var readoutViewModel: ReadoutViewModel
    var keypadViewModel: KeypadViewModel
    
    //TODO: Needs to be moved
    @Published var storedValue: [Int] = []
    @Published var displayedValue: [Int] = []
    @Published var isError: Bool = false
    @Published var currentOperation: String = "None"
    
    init() {
        self.calculatorModel = CalculatorModel()
        self.readoutViewModel = ReadoutViewModel(calculatorModel: calculatorModel)
        self.keypadViewModel = KeypadViewModel(calculatorModel: calculatorModel)
        
        //TODO: Needs to be moved
        self.calculatorModel.calculatorModelInternalDisplayDelegate = self
    }
    
    //TODO: Needs to be moved
    func didUpdateStoredValue(_ value: [Int]) {
        storedValue = value
    }
        
    func didUpdateDisplayedValue(_ value: [Int]) {
        displayedValue = value
    }
    
    func didUpdateIsError(_ isError: Bool) {
        self.isError = isError
    }
    
    func didUpdateOperation(_ operation: OperationType) {
        currentOperation = operation.textValue
    }
}
