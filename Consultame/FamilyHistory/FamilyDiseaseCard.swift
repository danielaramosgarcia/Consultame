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
    var formattedDate: String {
        return formatDate(diagnosis_date)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(chronic_disease)
                    .font(.title2)
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
                Text("Diagnosticado: ")
                Text(formattedDate)
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

private func formatDate(_ dateString: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let date = formatter.date(from: dateString) {
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    } else {
        return "Invalid Date"
    }
}


struct FamilyDiseaseCard_Previews: PreviewProvider {
    static var previews: some View {
        FamilyDiseaseCard(relationship: "Madre", chronic_disease: "Asma", diagnosis_date: "2004-01-01T00:00:00.000Z", description: "No puede respirar bien")
    }
}
