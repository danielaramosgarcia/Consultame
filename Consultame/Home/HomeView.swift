//
//  HomeView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct HomeView: View {
        @State private var isInCita = false
        
        var body: some View {
            VStack {
                
                Button("+ Empieza una cita"){
                    isInCita = true
                }
                .buttonStyle(BotonesInicio(buttonColor: Color.black))
                .padding(.top, 50)
                .padding(.horizontal, 25)
                
                NavigationLink(destination: transcripcion(), isActive: $isInCita){
                    EmptyView()
                }
                
                CitasPrevias()
            }
        }
    }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
