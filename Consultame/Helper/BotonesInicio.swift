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
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.5 : 1)
        
    }
}
