//
//  FamilyDiseaseCard.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct FamilyDiseaseCard: View {
    let relationship: String
    let disease: String
    let color : Color
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Asma")
                Spacer()
            } // HStack
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.leading, 10)
            
            HStack {
                Text("Relacion: ")
                Text(relationship)
                Spacer()
            }
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.leading, 10)
            
            HStack {
                Text("Diagnosticado: 32/11/2003")
                Spacer()
            } // hstack
            .foregroundColor(.white)
            .padding(.top, 10)
            
            
        } // VStack
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .cornerRadius(15)
        
        
        
        
    } // body
}

struct FamilyDiseaseCard_Previews: PreviewProvider {
    static var previews: some View {
        FamilyDiseaseCard(relationship: "Madre", disease: "Asma", color: .cyan)
    }
}
