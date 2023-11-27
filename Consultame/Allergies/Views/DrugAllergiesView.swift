//
//  DrugAllergiesView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct DrugAllergiesView: View {
    let index = 0..<5

    var body: some View {
        VStack {
            ForEach(index, id: \.self) { _ in
                AllergiesCard()
            }
            Spacer()
        }
    }
}
struct DrugAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        DrugAllergiesView()
    }
}
