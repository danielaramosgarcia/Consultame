//
//  FamilyHistoryListView.swift
//  Consultame
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct FamilyHistoryListView: View {
    @StateObject var FamilyVM = FamilyViewModel()
    var randomColor = Utils.colors.randomElement() ?? "DefaulColor"
    var backgroundColor : Color{
        Color(randomColor)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Antecedentes Familiares")
                Spacer()
                NavigationLink(destination: AnyView(AddVaccineToUserView())) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                }
                
            } // hstack
            .padding()
            .font(.title)
            VStack{
                if FamilyVM.familyArray.isEmpty {
                    Text("No tienes antecedente familiar guardado")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(FamilyVM.familyArray, id: \.id) { family in
                            //                        let colorIndex = contact.id % Utils.colors.count
                            //                        let hexColor = Utils.colors[colorIndex]
//                            let color = Color(randomColor)
                            FamilyDiseaseCard(relationship: family.relationship.type, chronic_disease: family.chronic_disease.name, diagnosis_date: family.diagnosis_date, description: family.description)
                        } // for each
                    } // list
                    .listStyle(.plain)
                } // else
                Spacer()
            }
            .animation(.default)
            .task {
                do {
                    try await FamilyVM.getFamily()
                } catch {
                    print("error")
                }
            }

        }
    }
    
}
struct FamilyHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyHistoryListView()
    }
}
