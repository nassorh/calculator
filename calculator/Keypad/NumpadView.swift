//
//  NumpadView.swift
//  calculator
//
//  Created by Nassor, Hamad on 10/10/2024.
//

import SwiftUI

struct NumpadView: View {
    var inputNumberCallback: (Int) -> Void
    var buttonSize: CGFloat
    
    func keypadButton(number: Int) -> some View {
        Button(action: {inputNumberCallback(number)}){
            Text("\(number)")
                .frame(width: buttonSize, height: buttonSize)
                .font(.title)
                .background(.gray)
                .clipShape(Rectangle())
                .foregroundColor(.white)
        }
    }
    
    func placerHolder() -> some View {
        Button(action: {}){
            Text("?")
                .frame(width: buttonSize, height: buttonSize)
                .font(.title)
                .background(.gray)
                .clipShape(Rectangle())
                .foregroundColor(.white)
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                keypadButton(number: 7)
                keypadButton(number: 8)
                keypadButton(number: 9)
            }
            HStack{
                keypadButton(number: 4)
                keypadButton(number: 5)
                keypadButton(number: 6)
            }
            HStack{
                keypadButton(number: 1)
                keypadButton(number: 2)
                keypadButton(number: 3)
            }
            HStack{
                placerHolder()
                keypadButton(number: 0)
                placerHolder()
            }
        }
    }
}

#Preview {
    //TODO: ChatGPT generated, need to understand this
    NumpadView(inputNumberCallback: { number in
            print("Number pressed: \(number)")
    }, buttonSize: 80)
}
