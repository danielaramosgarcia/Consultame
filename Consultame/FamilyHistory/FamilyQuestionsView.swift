//
//  FamilyQuestionsView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.
//

import SwiftUI

struct FamilyQuestionsView: View {
    @State private var diagnosisDate = Date()
       @State private var description = ""
       @State private var chronicDiseaseName = ""
       @State private var relationshipType = ""
    let opcionesSexo = ["Hombre", "Mujer", "No especificar"]
    
    var body: some View {
        VStack {
            Image("familytree")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
            
            Text("Agrega")
                .font(.system(size: 45).bold())
                .multilineTextAlignment(.center)
            Text("Antecedentes Médicos Familiares")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            TextField("Nombre de enfermedad:", text: $chronicDiseaseName)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
                .padding(.top, 40)
            TextField("Descripción", text: $description)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
                .padding(.top, 10)

            DatePicker("Fecha diagnosticado", selection: $diagnosisDate, displayedComponents: .date)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
                .padding(.horizontal, 30)
                .padding(.top, 10)

            Picker("Sexo", selection: $relationshipType) {
                ForEach(opcionesSexo, id: \.self) { sexo in
                    Text(sexo)
                }
            }
            .padding(.top, 10)

            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "Agregar",
                textColor : Color.white,
                destinationView: AnyView(MainTabView())
            )
            .padding(.top, 40)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    FamilyQuestionsView()
}
