//
//  SectionCard.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct HabitsCard : View {
    
    var randomColor = Utils.colors.randomElement() ?? "DefaulColor"
    var backgroundColor : Color{
        Color(randomColor)
    }
    
    let text: String
    let image: Image
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color.accentColor)
                Spacer()
            } // hstack
            
            HStack {
                Text(text)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing])
                Spacer()
                
            }
        } // vstack
        .padding()
        .background(backgroundColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 10)
        
        
        
    }
}


struct HabitsCard_Previews: PreviewProvider {
    static var previews: some View {
        HabitsCard(text: "Vacunas", image: Image("1"))
    }
}
