//
//  StartHistoryView.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct StartHistoryView: View {
    var body: some View {
        VStack {
            
            Image("heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .padding(.horizontal, 30)
    
             Text("Primero te preguntaré algunas cosas sobre tu historial médico, lo ouedes saltar pero te recomiento que lo contestemos de una vez.")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, weight: .semibold))
                .padding(.horizontal, 60)
            
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "¡Vamos!",
                textColor : Color.white,
                destinationView: AnyView(PersonalCoverView())
            )
            .padding(.top, 40)
            .padding(.horizontal, 60)
            
            
            
            }
        
        }
        
}

struct StartHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        StartHistoryView()
    }
}
