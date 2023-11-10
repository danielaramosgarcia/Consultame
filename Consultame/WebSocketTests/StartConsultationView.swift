//
//  StartConsultationView.swift
//  Consultame
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct StartConsultationView: View {
    @StateObject var webSocketManager = WebSocketManager()

    var body: some View {
        VStack {
            Text("Inicio de consulta")
                .font(.title)
            Text("Proporciona la siguiente clave a tu medico")
            
            if let roomkey = webSocketManager.roomKey {
                Text("Room Key: \(roomkey)")
                    .font(.title)
                    .padding()
            } else {
                Text("Connecting...")
                    .font(.title)
                    .padding()
            }
                
            
            
        } // vstack
        .padding(.bottom, 50)
    } // body
}

struct StartConsultationView_Previews: PreviewProvider {
    static var previews: some View {
        StartConsultationView()
    }
}