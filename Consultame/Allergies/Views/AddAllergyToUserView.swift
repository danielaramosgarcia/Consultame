//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI
struct AddAllergyToUserView: View {
    @StateObject var AllergyVM = AllergiesViewModel()

    @State private var allergySelection: Int = 0
    @State private var searchText = ""
    @State private var selectedDate = Date()
    @State private var tipoAlergia = 2

    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false

    var filteredAllergies: [Allergy] {
        let selectedCategory = tipoAlergia
        return AllergyVM.Allalergies.filter { $0.allergy_type_id == selectedCategory}
    }
    
    var searchResults : [Allergy] {
        searchText.isEmpty ? filteredAllergies : filteredAllergies.filter{$0.name.contains(searchText)}
    }

    var body: some View {
        VStack{
            VStack {
                Text("Añadir nueva alergia")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .trailing, .leading])
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack {
                    Picker("Tipo alergia", selection: $tipoAlergia) {
                        Text("Alimentos").tag(1)
                        Text("Medicamentos").tag(2)
                        Text("Otros").tag(3)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 20)
                }
                
                SearchBar(text: $searchText, placeholder: "Buscar")
                    .padding()
                
                List {
                    Picker(selection: $allergySelection, label: Text("Alergia")) {
                        ForEach(searchResults, id: \.id) { item in
                            Text(item.name).tag(item.id)
                        }
                    }
                    .pickerStyle(.inline)
                    .task {
                        do {
                            try await AllergyVM.getAllAllergies()
                            if AllergyVM.Allalergies.count > 0 {
                                allergySelection = AllergyVM.Allalergies[0].id
                            }
                        } catch {
                            print("error")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
            }
            
            Spacer()
            
            Button("Añadir") {
                Task {
                    do {
                        try await AllergyVM.postAllergyToUser(allergy_id: allergySelection)
                    } catch {
                        print("error al crear alergia")
                    }
                }
            }
            .buttonStyle(BotonesInicio(buttonColor: Color("AccentColor")))
            .frame(maxWidth: .infinity)
            .font(.title2)
            .padding(.horizontal, 30)
            .padding()
        }

        .onReceive(AllergyVM.$allergyCreatedSuccessfully) { isSuccess in
            if let success = isSuccess {
                if success {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showAlert = true
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Hubo un error al agregar la vacuna."), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddAllergyToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddAllergyToUserView()
    }
}
