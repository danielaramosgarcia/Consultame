//
//  AddContactToUserView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct AddContactToUserView: View {
    @StateObject var ContactsVM = ContactsViewModel()
    
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State private var relationshipSelection: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    enum ActiveAlert { case nameAlert, apiErrorAlert }
    @State private var showAlert: Bool = false
    @State private var activeAlert : ActiveAlert = .nameAlert
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Agregar contacto")
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .trailing, .leading])
            .font(.title)
            .fontWeight(.bold)
            
            VStack{
                //Spacer()
                
                TextField("Nombre", text: $name)
                    .textFieldStyle(CommonTextInput(iconImage: "person"))
                    .padding(.horizontal, 30)
                
                TextField("Número celular", text: $phone)
                    .keyboardType(.numberPad)
                    .textFieldStyle(CommonTextInput(iconImage: "phone"))
                    .padding(.horizontal, 30)
                
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(CommonTextInput(iconImage: "tray"))
                    .padding(.horizontal, 30)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .foregroundColor(Color ("LightGray"))
                        .frame(height: 50)
                    
                    HStack{
                        Text("Tipo de relación ")
                            .foregroundColor(Color("TextGray"))
                        
                        Spacer()
                        
                        Picker(selection: $relationshipSelection, label: Text("Tipo de parentesco")) {
                            ForEach(ContactsVM.relationshipsArr, id: \.id) { item in
                                Text(item.type)
                                    .tag(item.id)
                            } // for each
                        } // Picker
                        .pickerStyle(.menu)
                        .task {
                            do {
                                try await ContactsVM.getRelationships()
                                if ContactsVM.relationshipsArr.count > 0 {
                                    relationshipSelection = ContactsVM.relationshipsArr[0].id
                                }
                            } catch {
                                print("error")
                            }
                        } // task
                    }
                    .padding()
                }
                .padding(.horizontal, 30)
                
                Spacer()
            } // Vstack
            .padding(.top, 30)
            
            Spacer()
            
            Button("Confirmar"){
                if name.isEmpty {
                    activeAlert = .nameAlert
                    showAlert = true
                } else {
                    Task {
                        do {
                            try await
                            ContactsVM.createContact(contactName: name, phoneNumber: phone, email: email, relationshipId: relationshipSelection)
                            
                        } catch {
                            print("error al crear el contacto")
                        }
                    } // task
                } // else
                
            } // button
            .buttonStyle(BotonesInicio(buttonColor: Color("AccentColor")))
            .frame(maxWidth: .infinity)
            .font(.title2)
            .padding(.horizontal, 30)
            .padding()
            
            
            
        } // vstack
        
        .onReceive(ContactsVM.$userCreatedSuccessfully) { isSuccess in
            if let success = isSuccess {
                if success {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    activeAlert = .apiErrorAlert
                    showAlert = true
                }
            }
        } // on receive
        .alert(isPresented: $showAlert) {
            switch activeAlert {
                        case .nameAlert:
                            return Alert(title: Text("Error"), message: Text("Debes llenar el campo de nombre para continuar."), dismissButton: .default(Text("OK")))
                        case .apiErrorAlert:
                            return Alert(title: Text("Error"), message: Text("Hubo un error al crear el usuario."), dismissButton: .default(Text("OK")))
                        }
        } // alert
        
        
    } // body
}

struct AddContactToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactToUserView()
    }
}
