//
//  QuestionarioInicialView.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 26/11/23.
//

//
//  QuestionarioInicialView.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 26/11/23.
//

import SwiftUI

struct AppointmentNameView: View {
    @State private var appointmentName: String = ""
    @State private var showError = false
    @State private var shouldNavigate = false

    var body: some View {
        VStack {
            NavigationLink(
                destination: StartConsultationView(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
            )
            .hidden()
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Ingresa el nombre de tu cita:")
                    .font(.title)
                TextField("Nombre de la cita", text: $appointmentName)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .background(Color.white)
                    .cornerRadius(8)
                Button(action: {
                    if appointmentName.isEmpty {
                        showError = true
                    } else {
                        
                        let newConsultation = ConsultationModel(id: nil, name: appointmentName, description: nil, date: nil, user_id: User.user_id, doctor_id: nil, hospital_id: nil, created_at: nil)
                        createConsultation(consultation: newConsultation)
                        shouldNavigate = true
                        
                    }
                }) {
                    Text("Siguiente")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.black)
                        .cornerRadius(8)
                }
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Invalido"), message: Text("Porfavor ingresa el motivo de tu cita"), dismissButton: .default(Text("OK")))
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct AppointmentNameView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentNameView()
    }
}

