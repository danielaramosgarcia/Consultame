//
//  AllergiesCard.swift
//  Consultame
//
//  Created by Alumno on 17/11/23.
//

import SwiftUI
struct AllergiesCard: View {
    var alergia: AllergiesModel  // Pass the Allergy object
    
    var randomColor = Utils.colors.randomElement() ?? "DefaulColor"
    var backgroundColor : Color{
        Color(randomColor)
    }
    var body: some View

    {
        VStack(alignment: .leading) {
            HStack {
                Text(alergia.allergy.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            } // HStack
            .foregroundColor(.black)
            VStack(alignment: .leading){
            Text("Descripcion: ")
                HStack {
                    
                    Text(alergia.allergy.description!)
                    Spacer()
                }
        }
        }
        .padding(.leading, 5)
// VStack
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(15)
    }
}

struct AllergiesCard_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesCard(alergia: AllergiesModel(id: 1, user_id: 1, allergy: Allergy(id: 1, name: "Allergy 1", description: "Description 1", allergy_type_id: 1)))
    }
}
