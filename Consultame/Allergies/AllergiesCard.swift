//
//  AllergiesCard.swift
//  Consultame
//
//  Created by Alumno on 17/11/23.
//

import SwiftUI

struct AllergiesCard: View {
    var rectangle = CardRectangle(cardHeight: 70)

    
    var body: some View {

        ZStack {
            rectangle
            VStack(alignment: .leading){
                HStack {
                    Text("Nombre de la alergia")
                        .font(.headline)
                        .foregroundColor(Color("DarkGray2"))
                    Spacer()
                }.padding(.leading, 10)
                
                HStack{
                    Text("Descripcion")
                        .font(.subheadline)
                        .foregroundColor(Color("DarkGray2"))
                    Spacer()
                }.padding(.leading, 10)
                
            }
        }
    
    }
}



struct AllergiesCard_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesCard()
    }
}
