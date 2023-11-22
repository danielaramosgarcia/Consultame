//
//  MessageFromDoctorView.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import SwiftUI



struct MessageFromDoctorView: View {
    var DuringConsultationVM: DuringConsultationViewModel
    var consultation_id: Int
    var webSocketManager : WebSocketManager
    var waitTime : Int
    @State private var messageTimer: Timer?
    @State private var messageTimerStarted = false
    @State private var justSent = false
    
    @State private var sendCompleteMessageTimer: Timer?
    let sendCompleteMessageWaitTime = 7
    
    
    
    @ObservedObject var speechRecognizer : SpeechRecognizer
    
    
    @State private var typingAnimation = ""
    @State private var timer: Timer? = nil
    
    
    
    
    var body: some View {
        HStack {
            Text(speechRecognizer.transcript + (speechRecognizer.transcript.isEmpty ? "" : typingAnimation))
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(8)
                .onAppear {
                    // Para la animacion de los puntos
                    timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                        if !speechRecognizer.transcript.isEmpty {
                            self.typingAnimation = self.typingAnimation.count < 3 ? self.typingAnimation + "." : ""
                        }
                    }
                } // on appear
                .onChange(of: speechRecognizer.transcript) { message in
                    handleTextChange(message: message)
                } // on change
                .onDisappear {
                    timer?.invalidate()
                    timer = nil
                } // on disappear
            
            Spacer()
        } // hstack
    } // body
    
    
    
    func handleTextChange(message: String) {
        // Si acabamos de enviar un mensaje completo, restablecemos el estado y no hacemos nada más
        if justSent {
            justSent = false
            return
        }
        
        
        // Reiniciar el temporizador para enviar el mensaje completo si el mensaje ha cambiado
        if !message.isEmpty {
            sendCompleteMessageTimer?.invalidate()
            sendCompleteMessageTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(sendCompleteMessageWaitTime), repeats: false) { _ in
                Task {
                    if let newMessage = await self.DuringConsultationVM.createMessage(message: message, is_from_user: false, consultation_id: self.consultation_id) {
                        self.webSocketManager.sendCompleteMessage(newMessage)
                        self.speechRecognizer.stopTranscribing()
                        self.speechRecognizer.transcribe()
                        self.justSent = true
                    } else {
                        print("Error al crear el mensaje")
                    }
                    self.messageTimerStarted = false
                }
            }
        }
        
        
        // Enviar el mensaje actual que se está escribiendo por WebSocket
        if !messageTimerStarted && !message.isEmpty {
            messageTimerStarted = true
            
            messageTimer?.invalidate()
            messageTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(waitTime), repeats: false) { _ in
                // Enviar el mensaje actual
                self.webSocketManager.sendMessageBeingWritten(message: self.speechRecognizer.transcript, is_from_user: false)
                
                // Restablecer el estado del temporizador
                self.messageTimerStarted = false
            }
        }
        
    } // handle Text Change
    
} // view

struct MessageFromDoctorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDuringConsultationVM = DuringConsultationViewModel()
        let speechRecognizer = SpeechRecognizer()
        let mockWebSocketManager = WebSocketManager()
        let mockWaitTime = 3

        
        MessageFromDoctorView(DuringConsultationVM: mockDuringConsultationVM, consultation_id: 1, webSocketManager: mockWebSocketManager, waitTime: mockWaitTime, speechRecognizer: speechRecognizer)
    }
}