//
//  ContentView.swift
//  calculator
//
//  Created by Nassor, Hamad on 04/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack{
                ReadoutView(viewModel: viewModel.readoutViewModel, longEdge: 30, shortEdge: 5, lineSpacing: 5)
                KeypadView(viewModel: viewModel.keypadViewModel, buttonSize: 80)
            }
        } else {
            HStack{
                VStack(alignment: .leading){
                    Text("Stored Value: \(viewModel.storedValue)")
                                    .font(.title)
                    Text("Displayed Value: \(viewModel.displayedValue)")
                        .font(.title)
                    Text("Is Error: \(viewModel.isError ? "true" : "false")")
                        .font(.title)
                    Text("Current Operation: \(viewModel.currentOperation)")
                        .font(.title)
                }
                .padding(15)
                Spacer()
                VStack{
                    ReadoutView(viewModel: viewModel.readoutViewModel, longEdge: 30, shortEdge: 5, lineSpacing: 5)
                        .frame(width: 400)
                    KeypadView(viewModel: viewModel.keypadViewModel, buttonSize: 75)

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
