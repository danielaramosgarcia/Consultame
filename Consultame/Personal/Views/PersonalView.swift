import SwiftUI

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
                    VStack{
                        ListItemView(label: "Nombre", value: $personalVM.personal.name, showEditButton: false, isEditing: $personalVM.isPersonalInfoEditing)
                        ListItemView(label: "Correo Electrónico", value: $personalVM.personal.email, showEditButton: false, isEditing: $personalVM.isPersonalInfoEditing)
                        ListItemView(label: "Teléfono", value: $personalVM.personal.phone_number, showEditButton: false, isEditing: $personalVM.isPersonalInfoEditing)
                        ListItemView(label: "Fecha de nacimiento:", value: $personalVM.personal.birth_date, showEditButton: false, isEditing: $personalVM.isPersonalInfoEditing)
                    }
                    .padding()
                }
                .textCase(nil)
                .listRowInsets(EdgeInsets())
            

                // Sección de Datos Médicos
                Section(header: Text("Datos Médicos").font(.headline)) {
                    VStack{
                        HStack {
                            Spacer()
                            Button(action: {
                                personalVM.toggleLocationInfoEditing()
                            }) {
                                HStack {
                                    Image(systemName: "square.and.pencil")
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding()
                            .foregroundColor(.black)
                        }
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        ListItemView(label: "Tipo de sangre", value: $personalVM.personal.blood_type.type, showEditButton: false, isEditing: $personalVM.isMedicalInfoEditing)
                        ListItemView(label: "Peso:", value: $personalVM.personal.weight, showEditButton: false, isEditing: $personalVM.isMedicalInfoEditing)
                        ListItemView(label: "Altura:", value: $personalVM.personal.height, showEditButton: false, isEditing: $personalVM.isMedicalInfoEditing)
                    }
                    .padding()
                }
                .textCase(nil)
                .listRowInsets(EdgeInsets())
                
                // Sección de Información de Ubicación
//                Section(header: Text("Información de Ubicación").font(.headline)) {
//                VStack{
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            personalVM.toggleLocationInfoEditing()
//                        }) {
//                            HStack {
//                                Image(systemName: "square.and.pencil")
//                            }
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                        }
//                        .padding()
//                        .foregroundColor(.black)
//                    }
//                }
//
//                    ForEach(personalVM.personal.addresses, id: \.id) { address in
//                        VStack(alignment: .leading, spacing: 5) {
//                            ListItemView(label: "Nombre", value: address.street_line_1, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                            ListItemView(label: "Correo Electrónico", value: address.street_line_2, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                            ListItemView(label: "Nombre", value: address.city, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                            ListItemView(label: "Correo Electrónico", value: address.state_province_region, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                            ListItemView(label: "Nombre", value: address.postal_code, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                            ListItemView(label: "Correo Electrónico", value: address.country, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                            ListItemView(label: "Correo Electrónico", value: address.additional_info, showEditButton: false, isEditing: $personalVM.isLocationInfoEditing)
//                        }
//                        .padding()
//                    }
//                }
//
//                .textCase(nil)
//                .listRowInsets(EdgeInsets())
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
