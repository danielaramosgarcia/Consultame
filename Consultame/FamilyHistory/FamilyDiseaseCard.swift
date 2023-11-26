//
//  FamilyDiseaseCard.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//
import SwiftUI

struct FamilyDiseaseCard: View {
    let relationship: String
    let chronic_disease: String
    let diagnosis_date: String
    let description: String?
    var randomColor = Utils.colors.randomElement() ?? "DefaulColor"
    var backgroundColor : Color{
        Color(randomColor)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Asma")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text("Relación: ")
                Text(relationship)
            } // HStack
            .foregroundColor(.black)
            VStack(alignment: .leading){
            Text("Descripcion: ")
                HStack {
                    
                    Text(description!)
                    Spacer()
                }
        }
            HStack {
                Text("Diagnosticado: 32/11/2003")
                Spacer()
            } // hstack
            .foregroundColor(.black)


        }
        .padding(.leading, 5)
// VStack
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(15)
    } // body
}

struct FamilyDiseaseCard_Previews: PreviewProvider {
    static var previews: some View {
        FamilyDiseaseCard(relationship: "Madre", chronic_disease: "Asma", diagnosis_date: "20012008", description: "No puede respirar bien")
    }
}
