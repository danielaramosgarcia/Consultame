//
//  CitasPreviasCards.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPreviasCards: View {
    var rectangle = CardRectangle(cardHeight: 70)
    var cita: ConsultationModel
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {

        ZStack {
            rectangle
            HStack{
                Text(cita.name)
                    .padding(.all, 10)
                    .foregroundStyle(rectangle.textColor)
                Spacer()
                Text(dateFormatter.string(from: cita.date))
                    .padding(.all, 10)
                    .foregroundStyle(rectangle.textColor)
            }
        }
    }
}

struct CitasPreviasCards_Previews: PreviewProvider {
    static var previews: some View {
        // Declare and define a sample ConsultationModel
        let sampleCita = ConsultationModel(no: 1,
                                           name: "Sample Consultation",
                                           duration: 60,
                                           date: Date(),
                                           project: "Sample Project",
                                           owner: "Owner Name",
                                           status: "Pending")

        // Pass the sample data to CitasPreviasCards using the correct parameter name
        CitasPreviasCards(cita: sampleCita)
    }
}



