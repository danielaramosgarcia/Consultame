//
//  FamilyQuestionsView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.

import SwiftUI


struct FamilyQuestionsView: View {
//    @StateObject var FamilyVM = FamilyViewModel()
//    var familyArray : [FamilyModel] { FamilyVM.familyArray }
//
//    @State private var diseaseSelection: Int = 0
//    @State private var diagnosisDate = Date()
//       @State private var description = ""
//       @State private var chronicDiseaseName = ""
//       @State private var relationshipType = ""
//    let opcionesSexo = ["Hombre", "Mujer", "No especificar"]
//
//
//    var searchResults : [FamilyModel] {
//        chronicDiseaseName.isEmpty ? familyArray : familyArray.filter{$0.chronic_disease.contains(chronicDiseaseName)}
//    }
//
    var body: some View {
       VStack {
            Image("familypic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
//
//            Text("Agrega")
//                .font(.system(size: 45).bold())
//                .multilineTextAlignment(.center)
//            Text("Antecedentes Médicos Familiares")
//                .font(.system(size: 15))
//                .multilineTextAlignment(.center)
//
//            Picker(selection: $chronicDiseaseName, label: Text("Hello")) {
//                ForEach(searchResults, id: \.id) { item in
//                    Text(item.chronic_disease).tag(item.id)
//                } // for each
//            } // Picker
//            .pickerStyle(.inline)
//            .task {
//                do {
//                    try await FamilyVM.getFamily()
//                    if familyArray.count > 0 {
//                        diseaseSelection = familyArray[0].id
//                    }
//
//                } catch {
//                    print("error")
//                }
//            } // task
//
//
//
//            Picker("Nombre de enfermedad:", text: $chronicDiseaseName)
//                .textFieldStyle(CommonTextInput(iconImage: "tray"))
//                .padding(.horizontal, 30)
//                .padding(.top, 40)
//            TextField("Descripción", text: $description)
//                .textFieldStyle(CommonTextInput(iconImage: "tray"))
//                .padding(.horizontal, 30)
//                .padding(.top, 10)
//
//            DatePicker("Fecha diagnosticado", selection: $diagnosisDate, displayedComponents: .date)
//                .textFieldStyle(CommonTextInput(iconImage: "lock"))
//                .padding(.horizontal, 30)
//                .padding(.top, 10)
//
//            Picker("Sexo", selection: $relationshipType) {
//                ForEach(opcionesSexo, id: \.self) { sexo in
//                    Text(sexo)
//                }
//            }
//            .padding(.top, 10)
//
//
//            CustomButton(
//                buttonColor : Color("AccentColor"),
//                borderColor : Color.clear,
//                text : "Agregar",
//                textColor : Color.white,
//                destinationView: AnyView(MainTabView())
//            )
//            .padding(.top, 40)
//            .padding(.horizontal, 20)
        } // VStack
    }
}


struct FamilyQuestionsView_Previews: PreviewProvider {
   static var previews: some View {
       FamilyQuestionsView()
   }
}

