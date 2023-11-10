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
    @State private var isInHome = false
    
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
                    isInHome = true
                }
                .buttonStyle(BotonesInicio(buttonColor: Color("AccentColor")))
                .padding(.top, 10)
                .padding(.horizontal, 100)
            
            NavigationLink(destination: MainTabView(), isActive: $isInHome){
                EmptyView()
            }
                
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
}
    

struct InicioSesion_Previews: PreviewProvider {
    static var previews: some View {
        InicioSesion()
    }
}
