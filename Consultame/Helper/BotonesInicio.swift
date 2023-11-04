//
//  BotonesInicio.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct BotonesInicio: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View{
        configuration.label
            .padding()
            .foregroundColor(.white)
            .frame(width: 150, height: 50)
            .background(Color ("AccentColor"))
            .cornerRadius(15)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
