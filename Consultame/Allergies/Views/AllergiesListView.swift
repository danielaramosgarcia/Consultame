//
//  FoodAllergiesView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct AllergiesListView: View {
    
    var allergies: [AllergiesModel]


    var body: some View {
        VStack {
            ForEach(allergies){ allergy in
                VStack {
                    AllergiesCard() 
            
                }
            }
            Spacer()
        }
    }
}

struct AllergiesListView_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesListView(allergies: [
            AllergiesModel(id: 1, user_id: 1, allergy: Allergy(id: 1, name: "Allergy 1", description: "Description 1", allergy_type_id: 1)),
            AllergiesModel(id: 2, user_id: 1, allergy: Allergy(id: 2, name: "Allergy 2", description: "Description 2", allergy_type_id: 1)),
            // Add more dummy allergies as needed
        ])
    }
}
