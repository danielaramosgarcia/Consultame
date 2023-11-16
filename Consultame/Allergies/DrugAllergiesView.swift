//
//  DrugAllergiesView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct DrugAllergiesView: View {
    let index = 0..<5  // Declara un rango como índice

    var body: some View {
        VStack {  // Usa VStack para alinear verticalmente
            ForEach(index, id: \.self) { _ in
                CardRectangle()
            }
        }
    }
}
struct DrugAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        DrugAllergiesView()
    }
}
