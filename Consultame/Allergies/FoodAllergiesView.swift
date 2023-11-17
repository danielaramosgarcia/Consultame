//
//  FoodAllergiesView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct FoodAllergiesView: View {
    let index = 0..<5

    var body: some View {
        VStack {
            ForEach(index, id: \.self) { _ in
                VStack {
                    AllergiesCard() 
            
                }
            }
            Spacer()
        }
    }
}

struct FoodAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        FoodAllergiesView()
    }
}
