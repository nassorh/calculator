//
//  KeypadView.swift
//  calculator
//
//  Created by Nassor, Hamad on 10/10/2024.
//

import SwiftUI

struct KeypadView: View{
    private var viewModel:  KeypadViewModel;
    var buttonSize: CGFloat
    let darkGray = Color(red: 0.39, green: 0.39, blue: 0.38)

    init(viewModel:  KeypadViewModel, buttonSize: CGFloat){
        self.viewModel = viewModel
        self.buttonSize = buttonSize
    }
    
    func keypadButton(label: String, action: @escaping () -> Void, backgroundColor: Color = .black) -> some View {
        Button(action: action) {
            Text(label)
                .frame(width: buttonSize, height: buttonSize)
                .font(.title)
                .background(backgroundColor)
                .clipShape(Rectangle())
                .foregroundColor(.white)
        }
    }
    
    var body: some View {
            HStack(alignment: .bottom){
                
                VStack{
                    HStack{
                        keypadButton(label: "AC", action:  viewModel.clearNumbers, backgroundColor: darkGray)
                        keypadButton(label: "?", action: {}, backgroundColor: darkGray)
                        keypadButton(label: "?", action: {}, backgroundColor: darkGray)
                    }
                    NumpadView(inputNumberCallback: viewModel.inputNumber, buttonSize: buttonSize)
                }
                
                
                VStack{
                    keypadButton(label: "?", action: {}, backgroundColor: .orange)
                    keypadButton(label: "X", action: {viewModel.setOperation(operation: .multiplication)}, backgroundColor: .orange)
                    keypadButton(label: "-", action: {viewModel.setOperation(operation: .subtraction)}, backgroundColor: .orange)
                    keypadButton(label: "+", action: {viewModel.setOperation(operation: .addition)}, backgroundColor: .orange)
                    keypadButton(label: "=", action:  viewModel.performEquals, backgroundColor: .orange)
                }
            }
    }
}

#Preview {
    KeypadView(viewModel: KeypadViewModel(calculatorModel: CalculatorModel()),buttonSize: 80)
}
