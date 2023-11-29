//
//  RegisterView.swift
//  Consultame
//
//  Created by admin on 06/11/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var nombreCompleto = ""
    @State var correo = ""
    @State private var contrasena = ""
    @State private var contrasenaRepetida = ""
    @State var sexo = ""
    let opcionesSexo = ["Hombre", "Mujer", "No especificar"]
    @State var showError: Int?
    
    // Minimo una letra mayuscula, un numero, un caracter especial y minimo 6 characteres
    // #EstoEsParaTiProfe
    let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{6,}$"
    var passwordTest: NSPredicate{
        NSPredicate(format: "SELF MATCHES %@", self.passwordRegex)
    }
    
    var body: some View {
        VStack {
            Image("register")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
                .padding()
            Text("Regístrate")
                .font(.system(size: 45).bold())
                .multilineTextAlignment(.center)
            Text("Crea tu cuenta y comienza a usar la app")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            TextField("Nombre completo", text: $nombreCompleto)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
            TextField("Correo", text: $correo)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
            SecureField("Contraseña", text: $contrasena)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
                .padding(.horizontal, 30)
            SecureField("Repetir contraseña", text: $contrasenaRepetida)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
                .padding(.horizontal, 30)
            Picker("Sexo", selection: $sexo) {
                ForEach(opcionesSexo, id: \.self) { sexo in
                    Text(sexo)
                }
            }
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "Registrarme",
                textColor : Color.white,
                destinationView: AnyView(StartHistoryView()),
                action: {
                    if nombreCompleto.isEmpty || correo.isEmpty || contrasena.isEmpty || contrasenaRepetida.isEmpty || sexo.isEmpty {
                        // Show error to the user indicating all fields are mandatory
                        showError = 1
                    } else if !correo.contains("@") || !correo.contains(".") {
                        showError = 2
                    } else if !passwordTest.evaluate(with: contrasena) {
                        showError = 3
                    } else if contrasena != contrasenaRepetida {
                        showError = 3
                    }

                }
            )
            .padding(.top, 40)
            .padding(.horizontal, 20)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
