//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct AddVaccineToUserFormView: View {
    @StateObject var VaccineVM = VaccineViewModel()
    var vaccineArr : [VaccineModel] { VaccineVM.vaccineArr }
    
    @State private var vaccineSelection = VaccineModel(id: 0, name: "Select", image: "", description: "")
    @State private var searchText = ""
    @State private var selectedDate = Date()
    
    let dateFormatter = DateFormatter()
    
    
    var searchResults : [VaccineModel] {
        searchText.isEmpty ? vaccineArr : vaccineArr.filter{$0.name.contains(searchText)}
    }
    
    var body: some View {
        VStack {
            
            
            
        Text("Nombre de la vacuna")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .trailing, .leading])
                .font(.title)
                .fontWeight(.light)
            
            
            SearchBar(text: $searchText, placeholder: "Nombre de vacuna")
                .padding()
            Picker(selection: $vaccineSelection, label: Text("Hello")) {
                ForEach(searchResults, id: \.self) { item in
                    Text(item.name).tag(item as VaccineModel?)
                } // for each
            } // Picker
            .task {
                do {
                    try await VaccineVM.getVaccines()
                } catch {
                    print("error")
                }
            } // task
            
            
            
            
            Text("Fecha de aplicacion")
                .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .trailing, .leading])
            .font(.title)
            .fontWeight(.light)
            
            
            DatePicker(
                    "Start Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding([.trailing, .leading])
            
            Button(action: {print(selectedDate)}) {
                Text("Anadir")
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .font(.title2)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
            

        } // vstack
    } // Body
}

struct AddVaccineToUserFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccineToUserFormView()
    }
}
