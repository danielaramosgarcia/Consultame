//
//  FoodAllergiesView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct FoodAllergiesView: View {
    let index = 0..<5  // Declara un rango como índice

    var body: some View {
        VStack {  // Usa VStack para alinear verticalmente
            ForEach(index, id: \.self) { _ in
                VStack {
                    CardRectangle() // Rectangle que representa la tarjeta
                    
                
            
                }
            }
        }
    }
}

struct FoodAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        FoodAllergiesView()
    }
}
