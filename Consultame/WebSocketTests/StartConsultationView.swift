//
//  StartConsultationView.swift
//  Consultame
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

enum NavigationState: Hashable {
    case goToNextView
}

struct StartConsultationView: View {
    @StateObject var webSocketManager = WebSocketManager()
    @State private var navigationPath = [NavigationState]()
    
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                
                
                Button("Saltar") {
                    navigationPath = [.goToNextView]
                }
                .buttonStyle(BotonesInicio())
                .padding(.horizontal, 30)
                
                
                
            } // vstack
            .padding(.bottom, 50)
            .onChange(of: webSocketManager.saveMessages) { newValue in
                if newValue != nil {
                    navigationPath = [.goToNextView]
                }
            }
            
            
            .navigationDestination(for: NavigationState.self) { state in
                switch state {
                case .goToNextView:
//                    SendMessageView()
                    ChatView(webSocketManager: webSocketManager)
                }
            }
            
            
            
        } // navigation stack
    } // body
}

struct StartConsultationView_Previews: PreviewProvider {
    static var previews: some View {
        StartConsultationView()
    }
}
