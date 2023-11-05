//
//  ProfileView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(User.user_name)
                    .font(.title)
                ZStack{
                    Circle()
                        .fill(Color.purple)
                        .frame(width:120)
                    Text(String(User.user_name.first ?? " " ))
                        .foregroundColor(.white)
                        .font(.title)
                } // ZStack
                
                
                
                LazyVGrid(columns: columns, spacing: 10) {
                    SectionCard(text: "Vacunas", image: "syringe", destinationView: AnyView(VaccinesListView()))
                    SectionCard(text: "Contactos", image: "person", destinationView: AnyView(ContactsListView()))
                    SectionCard(text: "Medicamentos", image: "syringe", destinationView: AnyView(VaccinesListView()))
                    SectionCard(text: "Antecedentes familiares", image: "stethoscope", destinationView: AnyView(VaccinesListView())) // Imaginando que tienes otro símbolo.
                    SectionCard(text: "Vacunas", image: "syringe", destinationView: AnyView(VaccinesListView()))
                    SectionCard(text: "Contactos", image: "stethoscope", destinationView: AnyView(VaccinesListView())) // Imaginando que tienes otro símbolo.
                }
                .padding()
                
                Spacer()

                
                
                
            } // VStack
            
        } // navigation stack
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
