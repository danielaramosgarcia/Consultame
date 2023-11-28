//
//  PersonalView.swift
//  Consultame
//
//  Created by Dani Ramos on 06/11/23.
//

import SwiftUI

struct PersonalView: View {
    @StateObject private var PersonalVM = PersonalViewModel()

    var body: some View {
        VStack{
            List {
                Section(header: Label("Personal Information", systemImage: "person.fill")) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(PersonalVM.personal.name)")
                        Text("Email: \(PersonalVM.personal.email)")
                        Text("Birth Date: \(PersonalVM.personal.birth_date)")
                        Text("Phone Number: \(PersonalVM.personal.phone_number)")
                        Text("Weight: \(PersonalVM.personal.weight) kg")
                        Text("Height: \(PersonalVM.personal.height) cm")
                        
                    }
                }
                
                Section(header: Label("Address Information", systemImage: "location.fill")) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Street Line 1: \(PersonalVM.personal.address.street_line_1)")
                        Text("Street Line 2: \(PersonalVM.personal.address.street_line_2)")
                        Text("City: \(PersonalVM.personal.address.city)")
                        Text("State/Providence: \(PersonalVM.personal.address.state_providence)")
                        Text("Postal Code: \(PersonalVM.personal.address.postal_code)")
                        Text("Country: \(PersonalVM.personal.address.country)")
                        Text("Additional Info: \(PersonalVM.personal.address.additional_info)")
                    }
                    
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Información personal")
        }
            task{
                do {
                    try await PersonalVM.getPersonal()
                } catch {
                    print("error")
                }
            }
        }
    
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView()
    }
}
