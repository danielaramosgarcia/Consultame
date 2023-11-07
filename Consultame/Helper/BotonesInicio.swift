//
//  BotonesInicio.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct BotonesInicio: ButtonStyle {
    
    let buttonColor : Color
    let borderColor : Color
    
    init(buttonColor: Color = Color("AccentColor"), borderColor: Color = .clear) {
        self.buttonColor = buttonColor
        self.borderColor = borderColor
    }
    
    func makeBody(configuration: Configuration) -> some View{
        configuration.label
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(buttonColor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderColor, lineWidth: 2)
            )
            .cornerRadius(15)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
