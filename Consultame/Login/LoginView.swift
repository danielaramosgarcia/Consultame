//
//  InicioSesion.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct InicioSesion: View {
    
    @State var email = ""
    @State private var password = ""
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        
            VStack {
                NavigationLink(destination: StartHistoryView(), isActive: $viewModel.isSuccess) {
                    EmptyView()
                }
                Text("¡Bienvenido de vuelta!")
                    .font(.system(size: 45).bold())
                    .multilineTextAlignment(.center)
                
                Image("doctors")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
                    .padding()
                
                TextField("Correo Electronico", text: $email)
                    .textFieldStyle(CommonTextInput(iconImage: "tray"))
                    .padding(.horizontal, 30)
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(CommonTextInput(iconImage: "lock"))
                    .padding(.horizontal, 30)
                
                CustomButton(
                    buttonColor : Color("AccentColor"),
                    borderColor : Color.clear,
                    text : "Ingresar",
                    textColor : Color.white,
                    action: {
                        viewModel.loginUser(userLogin: LoginModel(email: email, password: password))
                    }
                )
                .padding(.top, 40)
                .padding(.horizontal, 100)
            }
            .padding()
            .alert(isPresented: $viewModel.isError) {
                Alert(
                    title: Text("Error al Iniciar Sesión"),
                    message: Text("Please check your credentials and try again.")
                )
            }
        }
    
}
    

struct InicioSesion_Previews: PreviewProvider {
    static var previews: some View {
        InicioSesion()
    }
}
