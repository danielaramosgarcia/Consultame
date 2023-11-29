//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI



struct AddFamilyDiseaseToUserView: View {
    @StateObject var VaccineVM = VaccineViewModel()
    @StateObject var ContactsVM = ContactsViewModel()
    var vaccineArr : [VaccineModel] { VaccineVM.vaccineArr }
    
    @State private var showDatePicker = false
    @State private var datePickerOffset: CGFloat = 0
    
    @State private var vaccineSelection: Int = 0
    @State private var searchText = ""
    @State private var selectedDate = Date()
    @State private var relationshipSelection: Int = 0

    
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false

    func loadRelationships() async {
        do {
                    try await ContactsVM.getRelationships()
            if ContactsVM.relationshipsArr.count > 0 {
                relationshipSelection = ContactsVM.relationshipsArr[0].id
            }
        } catch {
            print("error")
        }
    }
    
    var searchResults : [VaccineModel] {
        searchText.isEmpty ? vaccineArr : vaccineArr.filter{$0.name.contains(searchText)}
    }
   
    
    var body: some View {
        VStack() {
            
            VStack {
                SearchBar(text: $searchText, placeholder: "Buscar")
                    .padding()
                Text("Añadir antescedentes médicos familiares")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .trailing, .leading])
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Text("Tipo de parentesco: ")
                    
                    Picker(selection: $relationshipSelection, label: Text("Tipo de parentesco")) {
                        ForEach(ContactsVM.relationshipsArr, id: \.id) { item in
                            Text(item.type)
                                .tag(item.id)
                        } // for each
                    } // Picker
                    .pickerStyle(.menu)
                    .task {
                        do {
                            try await ContactsVM.getRelationships()
                            if ContactsVM.relationshipsArr.count > 0 {
                                relationshipSelection = ContactsVM.relationshipsArr[0].id
                            }
                        } catch {
                            print("error")
                        }
                    } // task
                }

                
                
                List{
                        Picker(selection: $vaccineSelection, label: Text("Tipo de enfermedad")) {
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

struct AddFamilyDiseaseToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddFamilyDiseaseToUserView()
    }
}
