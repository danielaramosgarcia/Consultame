//
//  SectionCard.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

    struct SectionCard : View {
        let text: String
        let image: String
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .foregroundColor(Color.accentColor)
                    Spacer()
                } // hstack
                
                HStack {
                    Text(text)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing])
                    Spacer()
                    
                }
            } // vstack
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
        }
    }


struct SectionCard_Previews: PreviewProvider {
    static var previews: some View {
        SectionCard(text: "Vacunas", image: "syringe")
    }
}
