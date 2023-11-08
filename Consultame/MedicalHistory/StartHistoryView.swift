//
//  StartHistoryView.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct StartHistoryView: View {
    var body: some View {
        ZStack {
            Color.white
                Image("heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 800)
             Text("Primero te preguntaré algunas cosas sobre tu historial médico, lo ouedes saltar pero te recomiento que lo contestemos de una vez")
                .padding(.top, 550)
                .multilineTextAlignment(.center)
                .frame(width: 240, height: 800)
                .font(.system(size:26))
                
            Button("¡Vamos!"){
                // navegacion de paginas
            }
            .buttonStyle(BotonesInicio())
            .padding(.top, 910)
            
            Button("Omitir"){
                // navegacion de paginas
            }
            .buttonStyle(BotonesInicio())
            .padding(.top, 1040)
            
            
            
            
            } .padding(.bottom, 390)
        
        
        
      
        
        }
        
}

struct StartHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        StartHistoryView()
    }
}
