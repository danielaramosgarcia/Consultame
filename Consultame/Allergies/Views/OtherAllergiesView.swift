//
//  OtherAllergiesView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct OtherAllergiesView: View {
    let index = 0..<5

    var body: some View {
        VStack {
            ForEach(index, id: \.self) { _ in
                AllergiesCard(allergy: <#T##Allergy#>)
            }
            Spacer()
        }
    }
}

struct OtherAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        OtherAllergiesView()
    }
}
