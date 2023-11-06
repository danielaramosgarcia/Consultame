//
//  HomeView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 60
                       , alignment: .center)
                .foregroundColor(.black)
                .overlay(
                    HStack{
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                        Text("Empieza una cita")
                            .foregroundColor(.white)
                    }
                )
                .onTapGesture {
                    // Function goes here
                }
            ZStack{ // TODO:convertir este rectangulo en componente para agregar varias vistas con este tipo de "informational bubble"
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 351, height: 101)
                    .foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, height: 300, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(color: Color.gray.opacity(0.6), radius: 5, x: 0, y: 5)
                    .padding(.vertical,20)
                    .overlay(
                        VStack{
                            Text("Citas Previas")
                                .padding(.bottom,20)
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 300, height: 50, alignment: .center)
                                .foregroundStyle(.gray)
                        }

                    )
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
