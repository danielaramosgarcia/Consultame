//
//  StartConsultationView.swift
//  Consultame
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI


struct StartConsultationView: View {
    var consultationID: Int

    @StateObject var messageManager = MessageManager()
        @StateObject var duringConsultationVM: DuringConsultationViewModel
        @StateObject var webSocketManager:  WebSocketManager // TODO: obtenerlo al darle click a la consulta
        

    init(consultationID: Int) {
        self.consultationID = consultationID // Asigna el ID de la consulta
                    let messageManager = MessageManager()
                    _messageManager = StateObject(wrappedValue: messageManager)
                    _duringConsultationVM = StateObject(wrappedValue: DuringConsultationViewModel(messageManager: messageManager))
                    _webSocketManager = StateObject(wrappedValue: WebSocketManager(consultationID: consultationID, messageManager: messageManager))
                } // init
    
    
    
    
    var body: some View {
        VStack {
            Image("doctor")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
                .padding()
            
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
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "Saltar",
                textColor : Color.white,
                destinationView: AnyView(ChatView(messageManager: messageManager, duringConsultationVM: duringConsultationVM, webSocketManager: webSocketManager))
            )
            .padding(.horizontal, 30)
            .padding(.top, 70)
            
            
        } // vstack
        
        .padding(.bottom, 50)
        
        
    } // body
        
}

struct StartConsultationView_Previews: PreviewProvider {
    static var previews: some View {
        StartConsultationView(consultationID: 1)
    }
}
