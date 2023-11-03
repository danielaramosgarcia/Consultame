//
//  WelcomPageView.swift
//  Consultame
//
//  Created by Alumno on 01/11/23.
//

import SwiftUI

struct WelcomPageView: View {
    @State private var currentIndex = 0
    
    var rectangleInfoArray = [
        RectangleInfo(title: "Que gusto verte!", description: "Tu salud es lo primero, y estamos aqui para ayudarte a gestionarla de manera eficaz."),
        RectangleInfo(title: "Prepara tu perfil", description: "Es esencial tener toda tu informacion de salud al dia. Desde alergias, medicacion actual hasta cirugias pasadas y condiciones cronicas, recopila y orgaiza todo en un solo lugar."),
        RectangleInfo(title: "Proceso de consulta", description: "Desarrollamos funciones para favorecer una comunicacion fluida y entendible entre tu y el medico"),
        RectangleInfo(title: "Tu historial", description: "Manten un registro de diagnosticos, recomendaciones y planes de tratamiento, todo en un solo lugar para un seguimiento eficaz y una mejor comprension de tu salud")
    ]
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(rectangleInfoArray.indices, id: \.self) { index in
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 550)
                        .shadow(
                            color: Color.black.opacity(0.1),
                            radius: 5, x: 0, y: 10
                        )
                    
                    VStack(spacing: 10) {
                        Text(rectangleInfoArray[index].title)
                            .font(.title)
                            .padding()
                        
                        Text(rectangleInfoArray[index].description)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .padding(.bottom, 80)
                    
                    // Carrusel de bolitas
                    HStack(spacing: 10) {
                        ForEach(rectangleInfoArray.indices, id: \.self) { i in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(i == currentIndex ? .black : .gray)
                        }
                    }
                    .padding(.bottom, 10)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
        Button(action: {}) {
            Text("Registrarse")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
        .padding(.bottom, 10)
        
        Button(action: {}) {
            Text("Ya tengo cuenta")
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
    }
}




struct WelcomPageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomPageView()
    }
}
