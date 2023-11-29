//
//  LoginView.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 29/11/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = InicioSesionRealViewModel()
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Login") {
                viewModel.loginUser(email: email, password: password)
            }
            .padding()
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

