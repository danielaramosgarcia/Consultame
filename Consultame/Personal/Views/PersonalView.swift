import SwiftUI

struct PersonalView: View {
    @StateObject private var personalVM = PersonalViewModel()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()

    var body: some View {
        VStack {
            List {
                Section(header: Text("Información Personal").font(.headline)) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nombre: \(personalVM.personal.name)")
                        Text("Correo Electrónico: \(personalVM.personal.email)")
                        Text("Fecha de Nacimiento: \(formattedBirthDate)")
                        Text("Número de Teléfono: \(personalVM.personal.phone_number)")
                    }
                }

                Section(header: Text("Datos Médicos").font(.headline)) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tipo de Sangre: \(personalVM.personal.blood_type.type)")
                        Text("Peso: \(personalVM.personal.weight) kg")
                        Text("Altura: \(personalVM.personal.height) cm")
                    }
                }

                Section(header: Text("Información de Ubicación").font(.headline)) {
                    ForEach(personalVM.personal.addresses, id: \.id) { address in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Línea de Calle 1: \(address.street_line_1)")
                            Text("Línea de Calle 2: \(address.street_line_2 ?? "")")
                            Text("Ciudad: \(address.city ?? "")")
                            Text("Estado/Provincia: \(address.state_providence_region)")
                            Text("Código Postal: \(address.postal_code ?? "")")
                            Text("País: \(address.country)")
                            Text("Información Adicional: \(address.additional_info ?? "")")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Información Personal")
        }
        .task {
            do {
                try await personalVM.getPersonal()
            } catch {
                print("Error: \(error)")
            }
        }
    }

    private var formattedBirthDate: String {
        guard let birthDate = dateFormatter.date(from: personalVM.personal.birth_date) else {
            return personalVM.personal.birth_date // Return original date if formatting fails
        }
        return dateFormatter.string(from: birthDate)
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView()
    }
}
