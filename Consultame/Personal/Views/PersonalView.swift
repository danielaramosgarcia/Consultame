import SwiftUI


//ho
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
                // Sección de Información Personal
                Section(header: Text("Información Personal").font(.headline)) {
                    ListItemView(label: "Nombre", value: personalVM.personal.name, showEditButton: false)
                    ListItemView(label: "Correo Electrónico", value: personalVM.personal.email, showEditButton: false)
                    ListItemView(label: "Fecha de Nacimiento", value: formattedBirthDate, showEditButton: false)
                    ListItemView(label: "Número de Teléfono", value: personalVM.personal.phone_number, showEditButton: false)
                }

                // Sección de Datos Médicos
                Section(header: Text("Datos Médicos").font(.headline)) {
                    ListItemView(label: "Tipo de Sangre", value: personalVM.personal.blood_type.type, showEditButton: true)
                    ListItemView(label: "Peso", value: "\(personalVM.personal.weight) kg", showEditButton: true)
                    ListItemView(label: "Altura", value: "\(personalVM.personal.height) cm", showEditButton: true)
                }

                // Sección de Información de Ubicación
                Section(header: Text("Información de Ubicación").font(.headline)) {
                    ForEach(personalVM.personal.addresses, id: \.id) { address in
                        VStack(alignment: .leading, spacing: 5) {
                            ListItemView(label: "Línea de Calle 1", value: address.street_line_1, showEditButton: true)
                            ListItemView(label: "Línea de Calle 2", value: address.street_line_2 ?? "", showEditButton: true)
                            ListItemView(label: "Ciudad", value: address.city ?? "", showEditButton: true)
                            ListItemView(label: "Estado/Provincia", value: address.state_province_region, showEditButton: true)
                            ListItemView(label: "Código Postal", value: address.postal_code ?? "", showEditButton: true)
                            ListItemView(label: "País", value: address.country, showEditButton: true)
                            ListItemView(label: "Información Adicional", value: address.additional_info ?? "", showEditButton: true)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
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
            return personalVM.personal.birth_date
        }
        return dateFormatter.string(from: birthDate)
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView()
    }
}

