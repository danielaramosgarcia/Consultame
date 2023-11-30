//
//  RegisterView.swift
//  Consultame
//
//  Created by admin on 06/11/23.
//

import SwiftUI

struct RegisterView: View {
    
    
    @State var userModel = SendUserModel(user_id: 0, name: "", email: "", password: "", sexo: -1)
    @State var contraseñaRepetida = ""
    let opcionesSexo = ["Hombre", "Mujer", "No especificar"]
    @State var showError =  false
    @State var errorMessage: String?

    

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
            TextField("Nombre completo", text: $userModel.name)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
            TextField("Correo", text: $userModel.email)
                .textFieldStyle(CommonTextInput(iconImage: "tray"))
                .padding(.horizontal, 30)
            SecureField("Contraseña", text: $userModel.password)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
                .padding(.horizontal, 30)
            SecureField("Repetir contraseña", text: $contraseñaRepetida)
                .textFieldStyle(CommonTextInput(iconImage: "lock"))
                .padding(.horizontal, 30)
            Picker("Sexo", selection: $userModel.sexo) {
                Text("Selecciona tu sexo").tag(-1) // This can be hidden from UI if needed
                ForEach(0..<opcionesSexo.count, id: \.self) { index in
                    Text(self.opcionesSexo[index]).tag(index+1)
                }
            }
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "Registrarme",
                textColor : Color.white,
                destinationView: AnyView(StartHistoryView()),
                action: {
                    if userModel.name.isEmpty || userModel.email.isEmpty || userModel.password.isEmpty || contraseñaRepetida.isEmpty || userModel.sexo == -1 {
                        var errorMsg = "Error, por favor, completa: "
                        errorMsg += userModel.name.isEmpty ? "Nombre Completo, " : ""
                        errorMsg += userModel.email.isEmpty ? "Correo, " : ""
                        errorMsg += userModel.password.isEmpty ? "Contraseña, " : ""
                        errorMsg += contraseñaRepetida.isEmpty ? "Repetir Contraseña, " : ""
                        errorMsg += userModel.sexo == -1 ? "Sexo, " : ""
                        errorMsg = String(errorMsg.dropLast(2)) // Removes the last comma and space
                        errorMessage = errorMsg

                        showError = true
                    } else if !userModel.email.contains("@") || !userModel.email.contains(".") {
                        errorMessage = "Formato de correo electronico incorrecto, porfavor ingresalo de nuevo"
                        showError = true
                    } else if !passwordTest.evaluate(with: userModel.password) {
                        errorMessage = "Asegurate que tu contraseña incluya minimo: una letra mayuscula, un numero, un caracter especial (!@#$%&*..) y una longitud minima de 6 characteres "
                        showError = true
                    } else if userModel.password != contraseñaRepetida {
                        errorMessage = "Asegurate que tus contraseñas coincidan"
                        showError = true
                    } else {
                        showError = false
                        let userOp = RegisterViewModel(UserInfo: userModel)
                        userOp.createUser()
                    }

                }
            )
            .padding(.top, 40)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Invalido"), message: Text(errorMessage ?? "Petición invalida, porfavor intentelo de nuevo"), dismissButton: .default(Text("OK")))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
