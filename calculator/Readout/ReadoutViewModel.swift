//
//  ReadoutViewModel.swift
//  calculator
//
//  Created by Nassor, Hamad on 09/10/2024.
//

import Foundation

class ReadoutViewModel: ObservableObject, CalculatorModelDelegate {
    var calculatorModel: CalculatorModel;
    var maxNumberOfDigits: Int;
    @Published var displayValue: [String] = [];
    @Published var isError: Bool = false;
    
    init(calculatorModel: CalculatorModel) {
        self.calculatorModel = calculatorModel
        self.maxNumberOfDigits = calculatorModel.maxNumberOfDigits
        self.calculatorModel.calculatorModelDelegate = self
    }
    
    func didUpdateDisplay(displayedValue: Int, error: Bool) {
        let currentValue = String(displayedValue)
        self.displayValue = currentValue.map{String($0)}
        self.isError = error
    }
}
