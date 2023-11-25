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
    var randomColor = Utils.colors.randomElement() ?? "DefaulColor"
    var backgroundColor : Color{
        Color(randomColor)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Asma")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("Relación: ")
                Text(relationship)
            } // HStack
            .foregroundColor(.black)
            HStack {
                Text("Diagnosticado: 32/11/2003")
                Spacer()
            } // hstack
            .foregroundColor(.black)


        }
        .padding(.leading, 10)
// VStack
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(15)
    } // body
}

struct FamilyDiseaseCard_Previews: PreviewProvider {
    static var previews: some View {
        FamilyDiseaseCard(relationship: "Madre", disease: "Asma")
    }
}
