//
//  TextToSpeechTestView.swift
//  Consultame
//
//  Created by Alumno on 19/11/23.
//

import SwiftUI

struct TextToSpeechTestView: View {
    var webSocketManager: WebSocketManager
    
    @State private var actualMessage = ""
    
    @State private var timerStarted = false
    @State private var sentMessages = [String]()
    @State private var debounceTimer: Timer?
    
    
    var body: some View {
        VStack {
            Text("Text to Speech (paciente escribe)")
                .padding()
                .font(.title)
            
            TextField("Escribe un mensaje...", text: $actualMessage)
                .onChange(of: actualMessage) { message in
                    handleTextChange(message: message)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding()
            
            Button("Enviar Mensaje") {
                sendUserMessage()
            }
            .buttonStyle(BotonesInicio())
            .padding(.horizontal, 30)
            
            
            // Lista de mensajes enviados
            ScrollView {
                ForEach(sentMessages, id: \.self) { message in
                    Text(message)
                        .padding()
                }
                
                Text(actualMessage)
                    .padding()
            } // scroll view
        } // vstack
    }
    
    func handleTextChange(message: String) {
        if(!timerStarted) {
            timerStarted = true
            
            debounceTimer?.invalidate()
            
            debounceTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                // Enviar el mensaje actual
                self.webSocketManager.sendMessageBeingWrittenByUser(self.actualMessage)
                print(self.actualMessage)
                
                // Restablecer el estado del temporizador
                self.timerStarted = false
            }
        } // if
        
    } // handle Text change
    
    func sendUserMessage() {
        webSocketManager.sendMessageWroteByUser(actualMessage)
        actualMessage = ""
        
        timerStarted = false
        debounceTimer?.invalidate()
    } // sendUserMessage
}

struct TextToSpeechTestView_Previews: PreviewProvider {
    static var previews: some View {
        let webSocketManager = WebSocketManager()
        
        TextToSpeechTestView(webSocketManager: webSocketManager)
    }
}
