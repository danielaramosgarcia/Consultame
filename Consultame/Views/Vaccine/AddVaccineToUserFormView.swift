//
//  AddVaccineToUserFormView.swift
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct AddVaccineToUserFormView: View {
    @StateObject var VaccineVM = VaccineViewModel()
    
    var vaccineArr : [VaccineModel] { VaccineVM.vaccineArr }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(vaccineArr) { c in
                    VStack {
                        Text(c.name)
                            .fontWeight(.light)
                    }
                }
            }
        } // ScrollView
        .padding(.horizontal, 20)
        .task {
            do {
                try await VaccineVM.getVaccines()
            } catch {
                print("error")
            }
        } // Task
    }
}

struct AddVaccineToUserFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccineToUserFormView()
    }
}
