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
            Text("¡Bienvenido de vuelta!")
                .font(.system(size: 45).bold())
                .multilineTextAlignment(.center)
                
            Image("doctors")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
                .padding()
            
            TextField("Usuario", text: $username)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
            SecureField("Contraseña", text: $password)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
                .padding(.horizontal, 30)
            
            Button("Ingresar"){
                // navegacion de paginas
            }
            .buttonStyle(BotonesInicio())
            .padding(.top, 10)
        }
        .padding()
    }
}

struct InicioSesion_Previews: PreviewProvider {
    static var previews: some View {
        InicioSesion()
    }
}
