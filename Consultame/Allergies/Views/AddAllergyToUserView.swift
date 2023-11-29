//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct AddAllergyToUserView: View {
    @StateObject var VaccineVM = VaccineViewModel()
    var vaccineArr : [VaccineModel] { VaccineVM.vaccineArr }
    
    @State private var vaccineSelection: Int = 0
    @State private var searchText = ""
    @State private var selectedDate = Date()
    @State private var tipoAlergia = "Alimentos"
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false

    
    
    
    var searchResults : [VaccineModel] {
        searchText.isEmpty ? vaccineArr : vaccineArr.filter{$0.name.contains(searchText)}
    }
   
    
    var body: some View {
        VStack() {
            
            VStack {
                SearchBar(text: $searchText, placeholder: "Buscar")
                    .padding()
                
                    HStack {
                        Text("Filtrar por tipo de alergia: ")
                        
                        Picker("Tipo alergia",
                               selection: $tipoAlergia) {
                            Text("Alimentos")
                                .tag("Alimentos")
                            Text("Medicamentos")
                                .tag("Medicamentos")
                            Text("Otros")
                                .tag("Otros")
                            
                        }
                    }
                
                
                Text("Añadir nueva alergia")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .trailing, .leading])
                    .font(.title)
                    .fontWeight(.bold)
                
                List{
                        Picker(selection: $vaccineSelection, label: Text("Tipo de alergia")) {
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
                    
                    } // List
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    
            } //VStack
            
                
    
            Spacer()
            
            Button("Añadir"){
                Task {
                    do {
                        try await
                        VaccineVM.setVaccineToUser(vaccineId: vaccineSelection, date: selectedDate)
                    } catch {
                        print("error al crear el contacto")
                    }
                } // task
                
            } // button
            .buttonStyle(BotonesInicio(buttonColor: Color("AccentColor")))
            .frame(maxWidth: .infinity)
            .font(.title2)
            .padding(.horizontal, 30)
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

struct AddAllergyToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddAllergyToUserView()
    }
}
