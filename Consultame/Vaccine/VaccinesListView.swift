//
//  VaccinesListView.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct VaccinesListView: View {
    @StateObject var VaccineVM = VaccineViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Mis vacunas")
                Spacer()
                NavigationLink(destination: AnyView(AddVaccineToUserView())) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                }
                
            } // hstack
            .padding()
            .font(.title)
            
            if VaccineVM.userVaccineArr.isEmpty {
                Text("No tienes vacunas registradas")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(VaccineVM.userVaccineArr, id: \.vaccine_id) { userVaccine in
//                        let colorIndex = userVaccine.vaccine_id % Utils.colors.count
//                        let hexColor = Utils.colors[colorIndex]
//                        let color = Color(hex: hexColor)
                        if let date = userVaccine.vaccination_date.toDate() {
                            let formattedDate = date.toString()
                            VaccineCard(vaccineName: userVaccine.vaccine.name, vaccineDate: formattedDate)
                                .listRowSeparator(.hidden)
                        }
                    } // for each
                    .onDelete(perform: deleteVaccine)
                } // list
                .listStyle(.plain)
                
            } // else
            
            
            Spacer()
            
        } // vstack
        .animation(.default)
        .task {
            do {
                try await VaccineVM.getUserVaccines()
            } catch {
                print("error")
            }
        } // task
        
    }
    
    func deleteVaccine(at offsets: IndexSet) {
        let vaccinesToDelete = offsets.map { VaccineVM.userVaccineArr[$0] }
        
        Task {
            for vaccine in vaccinesToDelete {
                do {
                    try await VaccineVM.deleteVaccineFromUser(vaccineId: vaccine.vaccine_id)
                } catch {
                    print("error al eliminar la vacuna del usuario")
                }
            }
        } // task
        
        VaccineVM.userVaccineArr.remove(atOffsets: offsets)
    }
}

struct VaccinesListView_Previews: PreviewProvider {
    static var previews: some View {
        VaccinesListView()
    }
}


extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC") // se interpreta como UTC
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        // ajustar la fecha para que sea mediodía en UTC
        var components = Calendar.current.dateComponents(in: TimeZone(identifier: "UTC")!, from: date)
        components.hour = 12
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)
    }
}





extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        return dateFormatter.string(from: self)
    }
}



extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

