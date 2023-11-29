//
//  ProfileView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct ColumnView: View {
    var number: Int?
    var string : String?
    @Environment(\.managedObjectContext) var moc

    var label: String
    @FetchRequest(sortDescriptors: []) var usuarios: FetchedResults<Usuario>

    var body: some View {
        VStack {
            if let actualNumber = number {
                Text("\(actualNumber)")
                    .font(.title)
                    .fontWeight(.bold)
            }

            if let actualString = string {
                Text(actualString)
                    .font(.title)
                    .fontWeight(.bold)
            }
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(minWidth: 0, maxWidth: .infinity,  minHeight: 50)
        .padding(5)
    }
}


struct ProfileView: View {
    @StateObject var ProfileVM = ProfileViewModel()
    @Binding var presentSideMenu: Bool
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                ZStack{
                    HStack {
                        Button{
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                                .padding()
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    
                }
                ZStack{
                        Circle()
                            .fill(Color("AccentColor"))
                            .frame(width:120)
                        Text(String(ProfileVM.profile.name.first ?? " " ))
                            .foregroundColor(.white)
                            .font(.title)
                    
                } // ZStack
                
                
                
                Text(ProfileVM.profile.name)
                    .font(.title)
                
                HStack(spacing: 0) {
                    ColumnView(number: ProfileVM.profile.age, label: "Edad")
                    Divider().background(Color.gray)
                    ColumnView(string: ProfileVM.profile.height, label: "Altura (cm)")
                    Divider().background(Color.gray)
                    ColumnView(string: ProfileVM.profile.weight, label: "Peso (kg)")
                    Divider().background(Color.gray)
                    ColumnView(string: ProfileVM.profile.blood_type.type, label: "Sangre")
                }
                .padding(10)
                .frame(height: 100)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    SectionCard(text: "Personal", image: "cross.circle", destinationView: AnyView(PersonalView()))
                    SectionCard(text: "Contactos", image: "person", destinationView: AnyView(ContactsListView()))
                    SectionCard(text: "Mis hábitos", image: "brain.head.profile", destinationView: AnyView(HabitsListView()))
                    SectionCard(text: "Mis alergias", image: "allergens", destinationView: AnyView(AllergiesTabView()))
                    SectionCard(text: "Historial Fam", image: "person.2", destinationView: AnyView(FamilyHistoryListView()))
                    SectionCard(text: "Mis vacunas", image: "syringe", destinationView: AnyView(VaccinesListView()))
                }
                .padding()
                
                Spacer()
                
            } // VStack

        }
        .task {
            do {
                try await ProfileVM.getProfile()
            } catch {
                print("error")
            }
        }// navigation stack
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        let isSideMenuOpen = Binding.constant(false)
        
        ProfileView(presentSideMenu: isSideMenuOpen)
    }
}
