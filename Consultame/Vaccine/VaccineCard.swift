//
//  VaccineCard.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct VaccineCard: View {
    let vaccineName: String
    let vaccineDate: String
    let color : Color
    
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(vaccineName)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
            } // hstack
            .padding(.leading, 10)
            
            
            HStack {
                Text("Fecha de aplicacion: ")
                Text(vaccineDate)
                Spacer()
                
            } // hstack
            .padding(.leading, 10)
            .font(.caption)
            .foregroundColor(.white.opacity(0.8))
                    
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(15)
            }
}

struct VaccineCard_Previews: PreviewProvider {
    static var previews: some View {
        VaccineCard(vaccineName: "Hepatitis B", vaccineDate: "03/11/23", color: .pink)
            .padding()
            }
}
