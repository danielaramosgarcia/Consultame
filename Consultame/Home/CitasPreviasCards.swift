//
//  CitasPreviasCards.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPreviasCards: View {
    var cita: ConsultationModel
    var rectangle = CardRectangle(cardHeight: 70)
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
                Text(cita.name ?? "No Name Found")
                    .padding(.all, 10)
                    .foregroundStyle(rectangle.textColor)
                Spacer()
                Text(cita.formatted_date)
                    .padding(.all, 10)
                    .foregroundStyle(rectangle.textColor)
            }
        }
    }
}


struct CitasPreviasCards_Previews: PreviewProvider {
    static var previews: some View {
        // Declare and define a sample ConsultationModel correctly
        let sampleCita = ConsultationModel(id: 1,
                                           name: "Sample Consultation",
                                           description: "Sample Description",
                                           date: Date(),
                                           user_id: 1,
                                           doctor_id: 1,
                                           hospital_id: 1,
                                           created_at: "\(Date())")

        CitasPreviasCards(cita: sampleCita)
    }
}




