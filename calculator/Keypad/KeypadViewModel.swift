//
//  NumpadViewModel.swift
//  calculator
//
//  Created by Nassor, Hamad on 10/10/2024.
//

import Foundation

class KeypadViewModel: ObservableObject {
    var calculatorModel: CalculatorModel;
    
    init(calculatorModel: CalculatorModel) {
        self.calculatorModel = calculatorModel
    }
    
    func inputNumber(newInput: Int) {
        calculatorModel.enterNumber(newInput)
    }
    
    func clearNumbers(){
        calculatorModel.clear()
    }
    
    func setOperation(operation: OperationType){
        calculatorModel.setOperation(operation: operation);
    }
    
    func performEquals(){
        calculatorModel.performEquals();
    }
}
