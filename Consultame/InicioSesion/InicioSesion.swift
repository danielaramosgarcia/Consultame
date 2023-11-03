//
//  InicioSesion.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct InicioSesion: View {
    
    @State var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            
            Image("doctors")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100) // Adjust the height as needed
            
            TextField("Usuario", text: $username)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
            SecureField("Contraseña", text: $password)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
        }
        .padding()
    }
}

struct InicioSesion_Previews: PreviewProvider {
    static var previews: some View {
        InicioSesion()
    }
}
