//
//  FamilyHistoryListView.swift
//  Consultame
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct FamilyHistoryListView: View {
    let index = 0..<5
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
            
            ForEach(index, id: \.self) { _ in
                FamilyDiseaseCard(relationship: "Madre", disease: "Asma")
            }
            .padding(3)
            .padding(.horizontal,10)

            Spacer()
        }
    }
}
struct FamilyHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyHistoryListView()
    }
}
