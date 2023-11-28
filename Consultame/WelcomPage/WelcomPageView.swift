//
//  WelcomPageView.swift
//  Consultame
//
//  Created by Alumno on 01/11/23.
//

import SwiftUI
import AVKit

struct WelcomPageView: View {
    @State private var currentIndex = 0
    
    var rectangleInfoArray = [
        RectangleInfo(title: "Que gusto verte!", description: "Tu salud es lo primero, queremos ayudarte a gestionarla fácilmente.", videoName: "gerardoP1"),
        RectangleInfo(title: "Prepara tu perfil", description: "Es esencial tener toda tu informacion de salud al día. ¡Organizala en un solo lugar!", videoName: "gerardoP2"),
        RectangleInfo(title: "Proceso de consulta", description: "Facilitamos la comunicación entre tú y tu médico", videoName: "gerardoP3"),
        RectangleInfo(title: "Tu historial", description: "Manten un registro de tus consultas, diagnósticos, recomendaciones y planes de tratamiento", videoName: "gerardoP4")
    ]
    
    var body: some View {
            NavigationView{
                VStack{
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
                                
                                
                                
                                VStack(spacing: 10){
                                    Text(rectangleInfoArray[index].title)
                                        .font(.title)
                                        .padding()
                                    VideoPlayerView(videoName: rectangleInfoArray[index].videoName)
                                        .frame(width: 700, height: 250)
                                        .padding()

                                    
                                    Text(rectangleInfoArray[index].description)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                } .frame(width: 280, height: 550)
                                
                                // Carrusel de bolitas
                                HStack(spacing: 10) {
                                    ForEach(rectangleInfoArray.indices, id: \.self) { i in
                                        Circle()
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(i == currentIndex ? Color("AccentColor") : .gray)
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                CustomButton(
                    buttonColor : Color("AccentColor"),
                    borderColor : Color.clear,
                    text : "Registrarse",
                    textColor : Color.white,
                    destinationView: AnyView(RegisterView())
                )
                .padding(.top, 10)
                .padding(.horizontal, 100)
                
                CustomButton(
                    buttonColor : Color("DarkGray"),
                    borderColor : Color.clear,
                    text : "Ya tengo cuenta",
                    textColor : Color.white,
                    destinationView: AnyView(InicioSesion())
                )
                .padding(.top, 10)
                .padding(.bottom, 15)
                .padding(.horizontal, 100)
                
                
                
            }
            
        }
        
    }
}


struct WelcomPageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomPageView()
    }
}
