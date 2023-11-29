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
    
    @State private var showDatePicker = false
    @State private var datePickerOffset: CGFloat = 0
    
    @State private var vaccineSelection: Int = 0
    @State private var searchText = ""
    @State private var selectedDate = Date()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false

    
    
    
    var searchResults : [VaccineModel] {
        searchText.isEmpty ? vaccineArr : vaccineArr.filter{$0.name.contains(searchText)}
    }
   
    
    var body: some View {
        VStack() {
            
            VStack {
                
                Text("Añadir nueva vacuna")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .trailing, .leading])
                    .font(.title)
                    .fontWeight(.bold)
                
                SearchBar(text: $searchText, placeholder: "Buscar vacuna")
                    .padding(.horizontal, 30)
                List{
                        Picker(selection: $vaccineSelection, label: Text("Vacunas")) {
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
                
                VStack{
                    
                    Button {
                        showDatePicker.toggle()
                        
                    } label: {
                        Text("+ Añadir fecha de aplicación")
                    }
                    .frame(maxWidth: .infinity)
                    .bold()
                    .offset(y: datePickerOffset)
                    
                    
                    if showDatePicker {
                        
                        DatePicker( "Fecha de Aplicación", selection: $selectedDate, displayedComponents: [.date] )
                            .datePickerStyle(.graphical)
                            .environment(\.locale, Locale(identifier: "es_ES"))
                            .padding()
                        
                    }
                }
                    
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

struct AddVaccineToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccineToUserView()
    }
}
