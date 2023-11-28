//
//  SpeechToTextTestView.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.

import SwiftUI

struct SpeechToTextTestView: View {
    var webSocketManager: WebSocketManager

    @State private var actualMessage = ""
    @State private var sentMessages = [String]()
    @State private var timer: Timer? = nil
    
    let messageInterval = 5.0
    
    var body: some View {
        VStack {
            Text("Speech to Text (doctor habla)")
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
        if message.last == " " { // Detectar espacio
            let words = message.split(separator: " ")
            if let lastWord = words.last {
                sendWord(word: String(lastWord))
            }
        }
        resetTimer() // Reiniciar el temporizador
    }
    
    func sendWord(word: String) {
//        webSocketManager.sendWord(word)
        
        print(word)
    }
    
    func sendMessage(message: String) {
        // TODO: Aqui tambien se debe de guardar en la base de datos
//        webSocketManager.sendMessage(message)
        print(message)
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: messageInterval, repeats: false) { _ in
            if !actualMessage.isEmpty {
                sendMessage(message: actualMessage)
                sentMessages.append(actualMessage)
                actualMessage = "" // Reiniciar entrada de texto
            }
        }
    }
}

struct SpeechToTextTestView_Previews: PreviewProvider {
    static var previews: some View {
        let webSocketManager = WebSocketManager(consultationID: 1)

        SpeechToTextTestView(webSocketManager: webSocketManager)
    }
}
