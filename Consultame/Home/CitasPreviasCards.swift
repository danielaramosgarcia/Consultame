//
//  CitasPreviasCards.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPreviasCards: View {
    var rectangle = CardRectangle(cardHeight: 70)
    
    var body: some View {

        ZStack {
            rectangle
            HStack{
                Text("Titulo de la Cita")
                    .padding(.all, 10)
                    .foregroundStyle(rectangle.textColor)
                Spacer()
                Text("Fecha")
                    .padding(.all, 10)
                    .foregroundStyle(rectangle.textColor)

            }
        }
    }
}



#Preview {
    CitasPreviasCards()
}
