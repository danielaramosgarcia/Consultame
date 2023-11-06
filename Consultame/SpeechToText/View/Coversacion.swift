//
//  Coversacion.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 06/11/23.
//

import SwiftUI

struct Coversacion: View {
    var body: some View {
        
        VStack{
            HStack{
                NavigationLink(destination: HomeView()) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
//                        .padding()
                    Text("Regresar")
                    
                }
                .foregroundColor(Color.gray)
                .frame(alignment: .leading)
                .padding(6)
                Spacer()
            }
            Text("Escucha")
                .font(.title)
                .bold()
                .padding(1)
            ListenBox()
                .padding(10)
            Text("Habla")
                .font(.title)
                .bold()
                .padding(1)
            SpeakBox()
                .padding(10)

            Button("Terminar"){
            } // button
            .buttonStyle(BotonesInicio())
            .padding(.bottom, 30)
            .frame(width: 400)
        }
        .padding(1)
    }
}

struct Coversacion_Previews: PreviewProvider {
    static var previews: some View {
        Coversacion()
    }
}
