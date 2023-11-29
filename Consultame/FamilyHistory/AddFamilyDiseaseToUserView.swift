//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI



struct AddFamilyDiseaseToUserView: View {
    @StateObject var FamilyVM = FamilyViewModel()
    @StateObject var ContactsVM = ContactsViewModel()
    
    @State private var showDatePicker = false
    @State private var datePickerOffset: CGFloat = 0
    
    @State private var diseaseSelection:Disease = Disease(id: 1, name: "", description: "", type_id: 1)
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
    
    var searchResults : [Disease] {
        searchText.isEmpty ? FamilyVM.diseases : FamilyVM.diseases.filter{$0.name.contains(searchText)}
    }
    
    
    var body: some View {
        VStack() {
            
            VStack {
                
                Text("Añadir antescedentes médicos familiares")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .trailing, .leading])
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    
                    HStack{
                        Text("Tipo de parentesco: ")
                        
                        Spacer()
                        
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
                }
                .padding(.horizontal, 50)
                
                DatePicker( "Fecha de diagnosis", selection: $selectedDate, displayedComponents: [.date] )
                    .datePickerStyle(.compact)
                    .environment(\.locale, Locale(identifier: "es_ES"))
                    .padding(.horizontal, 50)
                
                SearchBar(text: $searchText, placeholder: "Buscar enfermedad")
                    .padding(.horizontal, 30)
                
                List{
                    
                    Picker(selection: $diseaseSelection, label: Text("Enfermedades")) {
                        ForEach(searchResults, id: \.id) { item in
                            Text(item.name).tag(item)
                        } // for each
                    } // Picker
                    
                    .pickerStyle(.inline)
                    
                    
                    
                    
                } // List
                .scrollContentBackground(.hidden)
                .background(.clear)
                

                   
 
                .task {
                    do {
                        try await FamilyVM.getAllDisease()
                        if FamilyVM.diseases.count > 0 {
                            diseaseSelection = FamilyVM.diseases[0]
                            
                            
                        }
                        
                    } catch {
                        print("error")
                    }
                } // task
                
                
                Spacer()
                
                Button("Añadir"){
                    Task {
                        do {
                            try await
                            FamilyVM.postFamilyToUser(chronic_disease_id: diseaseSelection.id, relationship_id: relationshipSelection, diagnosis_date: selectedDate, description: diseaseSelection.description )
                            
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
            
            .onReceive(FamilyVM.$familyCreatedSuccessfully) { isSuccess in
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
}

struct AddFamilyDiseaseToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddFamilyDiseaseToUserView()
    }
}
