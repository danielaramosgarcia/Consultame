//
//  CitasPreviasCards.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPreviasCards: View {
    let backgroundColor = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    //let textColor = isColorDark(backgroundColor) ? Color.white : Color.black
    
    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(backgroundColor)
                .frame(height: 100)
            HStack{
                Text("Titulo de la Cita")
                    .padding(.all, 10)
                //    .foregroundStyle(textColor)
                Spacer()
                Text("Fecha de Hoy")
                    .padding(.all, 10)
                //    .foregroundStyle(textColor)

            }
        }
            }
        }



struct CitasPreviasCards_Previews: PreviewProvider {
    static var previews: some View {
        CitasPreviasCards()
    }
}
