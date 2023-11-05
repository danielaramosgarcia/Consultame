//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct AddVaccineToUserView: View {
    @StateObject var VaccineVM = VaccineViewModel()
    var vaccineArr : [VaccineModel] { VaccineVM.vaccineArr }
    
    @State private var vaccineSelection: Int = 0
    @State private var searchText = ""
    @State private var selectedDate = Date()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false

    
    
    
    var searchResults : [VaccineModel] {
        searchText.isEmpty ? vaccineArr : vaccineArr.filter{$0.name.contains(searchText)}
    }
   
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack {
                Text("Nombre de la vacuna")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .trailing, .leading])
                        .font(.title2)
                        .fontWeight(.light)
                    
                    
                    SearchBar(text: $searchText, placeholder: "Nombre de vacuna")
                        .padding()
                    Picker(selection: $vaccineSelection, label: Text("Hello")) {
                        ForEach(searchResults, id: \.id) { item in
                            Text(item.name).tag(item.id)
                        } // for each
                    } // Picker
                    .pickerStyle(.inline)
                    .task {
                        do {
                            try await VaccineVM.getVaccines()
                            if vaccineArr.count > 0 {
                                vaccineSelection = vaccineArr[0].id
                            }
                            
                        } catch {
                            print("error")
                        }
                    } // task
                
            }
        
            
            DatePicker(
                    "Fecha de aplicacion",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .padding()
                .font(.title2)
                .fontWeight(.light)
            
            
            Spacer()
            
            
            
            Button {
                Task {
                    do {
                        try await
                    VaccineVM.setVaccineToUser(vaccineId: vaccineSelection, date: selectedDate)
                        
                    } catch {
                        print("error al asignar vacuna al usuario")
                    }
                } // task 
               
            } label: {
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
        .onReceive(VaccineVM.$isVaccineSetToUserSuccesful) { isSuccess in
                    if let success = isSuccess {
                        if success {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                } // on receive
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Hubo un error al agregar la vacuna."), dismissButton: .default(Text("OK")))
                } // alert
    
            
    } // Body
}

struct AddVaccineToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccineToUserView()
    }
}
