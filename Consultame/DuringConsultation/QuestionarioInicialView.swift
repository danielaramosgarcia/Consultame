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
    @StateObject var createConsultationVM = NewConsultationViewModel()
    
    @State private var appointmentName: String = ""
    @State private var showError = false
    
    var body: some View {
        VStack {
            
            Spacer()
            VStack() {
                Image("text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .padding()
                
                Text("Ingresa el nombre de tu cita:")
                    .font(.title)
                
                TextField("Nombre de la cita", text: $appointmentName)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .background(Color.white)
                    .cornerRadius(8)
                
                CustomButton(
                    buttonColor: Color("AccentColor"),
                    borderColor: Color.clear,
                    text: "Siguiente",
                    textColor: Color.white,
                    destinationView: AnyView(StartConsultationView()),
                    asyncAction: {
                        if appointmentName.isEmpty {
                            showError = true
                        } else {
                            do {
                                // Usa 'try' para manejar errores lanzados por funciones asíncronas
                                try await createConsultationVM.createConsultation(name: appointmentName)
                                
                                // Continúa con cualquier lógica posterior aquí
                            } catch {
                                // Maneja el error aquí
                                // Por ejemplo, puedes mostrar un mensaje de error al usuario
                                print("Ocurrió un error: \(error)")
                            }
                        }
                )
                .padding(.top, 50)
                .padding(.horizontal, 25)
                    
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
}
struct AppointmentNameView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentNameView()
    }
}

