//
//  Readout.swift
//  calculator
//
//  Created by Nassor, Hamad on 08/10/2024.
//

import SwiftUI

struct ReadoutView: View {
    @ObservedObject var viewModel: ReadoutViewModel;
    var longEdge: CGFloat
    var shortEdge: CGFloat
    var lineSpacing: CGFloat
    
    var body: some View {
        let valuesArray = Array(viewModel.displayValue);
        
        HStack{
            if viewModel.isError {
                ForEach(0..<(viewModel.maxNumberOfDigits - 3), id: \.self){ index in
                    SevenSegmentView()
                }
                
                ForEach(["e","r","r"], id: \.self) { letter in
                    SevenSegmentView(displayText: letter)
                }
            } else {
                ForEach(0..<(viewModel.maxNumberOfDigits - valuesArray.count), id: \.self){ index in
                    SevenSegmentView()
                }
                
                ForEach(valuesArray, id: \.self) { number in
                    SevenSegmentView(displayText: String(number))
                }
            }
        }
        .padding(30)
        //TODO: Look at the right approach here for ui testing
        .accessibilityIdentifier("display")
        .accessibilityLabel(viewModel.isError ? "err" : viewModel.displayValue.joined(separator: ""))
    }
}

#Preview {
    ReadoutView(viewModel: ReadoutViewModel( calculatorModel: CalculatorModel()), longEdge: 30, shortEdge: 5, lineSpacing: 5)
        .frame(width: 500)
       
}
