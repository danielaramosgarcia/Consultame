import SwiftUI

struct AppointmentNameView: View {
    @StateObject var createConsultationVM = ConsultationStore()
    @State private var consultationID: Int?
    @State private var appointmentName: String = ""
    @State private var showError = false
    @State private var isLinkActive = false // Controla la activación del NavigationLink

    var body: some View {
        VStack {
            Spacer()
            VStack {
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

                Button(action: {
                    if appointmentName.isEmpty {
                        showError = true
                    } else {
                        Task {
                            do {
                                self.consultationID = try await createConsultationVM.createConsultation(name: appointmentName)
                                isLinkActive = true // Activa el enlace si la consulta se crea con éxito
                            } catch {
                                print("Error creating consultation: \(error)")
                            }
                        }
                    }
                }) {
                    Text("Siguiente")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color("AccentColor"))
                        .cornerRadius(15)
                }
                .padding(.top, 50)
                .padding(.horizontal, 25)

                NavigationLink(destination: StartConsultationView(consultationID: consultationID ?? -1), isActive: $isLinkActive) {
                    EmptyView()
                }
                .hidden()
            }

            .alert(isPresented: $showError) {
                Alert(title: Text("Invalido"), message: Text("Por favor ingresa el motivo de tu cita"), dismissButton: .default(Text("OK")))
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
