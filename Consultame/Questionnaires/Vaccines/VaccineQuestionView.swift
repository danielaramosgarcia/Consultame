//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct VaccineQuestionView: View {
    @StateObject var VaccineVM = VaccineViewModel()
    var vaccineArr : [VaccineModel] { VaccineVM.vaccineArr }
    
    @State private var vaccineSelection: Int = 0
    @State private var searchText = ""
    @State private var selectedDate = Date()
    @State private var description = ""

    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false

    
    
    
    var searchResults : [VaccineModel] {
        searchText.isEmpty ? vaccineArr : vaccineArr.filter{$0.name.contains(searchText)}
    }
   
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack {
                
                Image("VaccinePic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 320)
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
                .frame(maxHeight: 50)
                .padding(.horizontal, 30)
                
                DatePicker(
                    "Fecha de aplicacion",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .padding()
                .font(.title2)
                .fontWeight(.light)
                
                CustomButton(
                    buttonColor : Color("AccentColor"),
                    borderColor : Color.clear,
                    text : "Listo",
                    textColor : Color.white,
                    destinationView: AnyView(MainTabView())
                ){
                    Task {
                        do {
                            try await
                            VaccineVM.setVaccineToUser(vaccineId: vaccineSelection, date: selectedDate)
                            
                        } catch {
                            print("error al asignar vacuna al usuario")
                        }
                    } // task
                }
                .frame(maxWidth: .infinity)
                .font(.title2)
                .cornerRadius(10)
                .padding(.top, 50)
                .padding(.horizontal, 60)
                
                CustomButton(
                    buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                    text : "+ Añadir otra",
                    textColor : Color("AccentColor"),
                    destinationView: AnyView(VaccineQuestionView())
                ){
                    Task {
                        do {
                            try await
                            VaccineVM.setVaccineToUser(vaccineId: vaccineSelection, date: selectedDate)
                            
                        } catch {
                            print("error al asignar vacuna al usuario")
                        }
                    } // task
                }
                .font(.title2)
                .cornerRadius(10)
                .padding(.top, 20)
                .padding(.horizontal, 60)
                
                
                
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
            
        }
    } // Body
}

struct VaccineQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        VaccineQuestionView()
    }
}
