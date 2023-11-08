//
//  ContactsListView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct ContactsListView: View {
    @StateObject var ContactsVM = ContactsViewModel()
//    @State var contacts:ContactModel? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Mis contactos")
                Spacer()
                NavigationLink(destination: AddContactToUserView()) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .foregroundColor(Color.accentColor)
                } // NavigationLink
                
            } // hstack
            .padding()
            .font(.title)
            
            
            if ContactsVM.contactsArr.isEmpty {
                Text("No tienes contactos registradas")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(ContactsVM.contactsArr, id: \.id) { contact in
                        let colorIndex = contact.id % Utils.colors.count
                        let hexColor = Utils.colors[colorIndex]
                        let color = Color(hex: hexColor)
                        HStack {
                            ZStack{
                                Circle()
                                    .fill(color)
                                    .frame(width: 50)
                                Text(String(contact.contact_name.first ?? " " ))
                                    .foregroundColor(.white)
                                    .font(.title)
                            } // ZStack
                            .padding(.trailing, 10)
                            VStack {
                                HStack {
                                    Text(contact.contact_name)
                                    Spacer()
                                }
                                HStack {
                                    Text(contact.relationship.type)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            } // VStack
                            
                            if let phoneNumber = contact.phone_number, !phoneNumber.isEmpty {
                                Image(systemName: "phone.fill")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            } else if let email = contact.email, !email.isEmpty {
                                Image(systemName: "envelope.fill")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                            } // else if
                            
                            
                        } // Hstack
                        
                    } // for each
                    .onDelete(perform: deleteContact)
                } // list
                .listStyle(.plain)
                
            } // else
            
            Spacer()
        } // VStack
        .animation(.default)
        .task {
            do {
                try await ContactsVM.getContacts()
            } catch {
                print("error")
            }
        } // task
        
    } // body
    
    func deleteContact(at offsets: IndexSet) {
        let contactsToDelete = offsets.map { ContactsVM.contactsArr[$0] }
        
                Task {
                    for contact in contactsToDelete {
                        do {
                            try await ContactsVM.deleteContactFromUser(contactId: contact.id)
                        } catch {
                            print("error al eliminar el contacto del usuario")
                        }
                    }
                } // task
        
        ContactsVM.contactsArr.remove(atOffsets: offsets)
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
