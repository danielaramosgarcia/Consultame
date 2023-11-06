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
                    SectionCard(text: "Hábitos", image: "brain.head.profile", destinationView: AnyView(HabitsListView()))
                    SectionCard(text: "Alergías", image: "allergens", destinationView: AnyView(AllergiesTabView())) // Imaginando que tienes otro símbolo.
                    SectionCard(text: "Vacunas", image: "syringe", destinationView: AnyView(VaccinesListView()))
                    SectionCard(text: "Familiares", image: "person.2", destinationView: AnyView(FamilyHistoryListView())) // Imaginando que tienes otro símbolo.
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
