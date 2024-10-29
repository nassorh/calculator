//
//  SevenSegmentView.swift
//  calculator
//
//  Created by Nassor, Hamad on 04/10/2024.
//

import SwiftUI

struct SevenSegmentView: View {
    var displayText: String?
    let activeColour: Color;
    let inactiveColour: Color;
    let longEdge: CGFloat;
    let shortEdge: CGFloat;
    let lineSpacing: CGFloat;
    
    let displayedTextRectangleMap = [
        "e":[true,true,false,true,true,false,true],
        "r":[false,false,false,true,true,false,false],
        "0":[true,true,true,false,true,true,true],
        "1":[false,false,true,false,false,true,false],
        "2":[true,false,true,true,true,false,true],
        "3":[true,false,true,true,false,true,true],
        "4":[false,true,true,true,false,true,false],
        "5":[true,true,false,true,false,true,true],
        "6":[true,true,false,true,true,true,true],
        "7":[true,false,true,false,false,true,false],
        "8":[true,true,true,true,true,true,true],
        "9":[true,true,true,true,false,true,true]
    ]
    
    init (displayText: String? = nil, activeColour: Color = Color.black, inactiveColour: Color = Color.gray, longEdge: CGFloat, shortEdge: CGFloat, lineSpacing: CGFloat){
        self.displayText = displayText;
        self.activeColour = activeColour;
        self.inactiveColour = inactiveColour.opacity(0.4);
        self.longEdge = longEdge;
        self.shortEdge = shortEdge;
        self.lineSpacing = lineSpacing;
    }
    
    func colorForSegment(index: Int) -> Color {
        guard let displayText = displayText, let isActive = displayedTextRectangleMap[displayText]?[index], isActive else {
            return inactiveColour
        }
        
        return activeColour
    }
    
    func segment(index: Int, isVertical: Bool) -> some View {
        return Rectangle()
            .fill(colorForSegment(index: index))
            .frame(width: isVertical ? shortEdge : longEdge, height: isVertical ? longEdge : shortEdge)
    }
    
    var body: some View {
        VStack(spacing: lineSpacing){
            segment(index: 0, isVertical: false)
            
            HStack{
                segment(index: 1, isVertical: true)
                Spacer()
                segment(index: 2, isVertical: true)
            }
            
            VStack{
                segment(index: 3, isVertical: false)
            }
            
            HStack{
                segment(index: 4, isVertical: true)
                Spacer()
                segment(index: 5, isVertical: true)
            }
            
            segment(index: 6, isVertical: false)
        }
    }
}

#Preview {
    SevenSegmentView(displayText: "r", longEdge: 300, shortEdge: 50, lineSpacing: 2)
        .frame(width: 400)
}
