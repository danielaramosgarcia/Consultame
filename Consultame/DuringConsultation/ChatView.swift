//
//  ChatView.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import SwiftUI

struct ChatView: View {
    var webSocketManager: WebSocketManager
    @StateObject var DuringConsultationVM = DuringConsultationViewModel()
    
    @State private var actualPatientMessage = ""
    @State private var patientTimerStarted = false
    @State private var patientDebounceTimer: Timer?
    let patientWaitTime = 5
    
    
    
    let consultation_id = 1 // obtenerlo al darle click a la consulta especifica
    
    
    var body: some View {
        VStack {
            // Header with back button, profile picture, and name
            HStack {
                Spacer() // Push the profile picture and name to the middle
                
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                    Text("Dr. Juan Cepeda")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            
            // Chat messages
            List {
                ForEach(DuringConsultationVM.messagesArr) { message in
                    MessageRowView(message: message)
                        .contextMenu {
                            Button("Summary") {
                                // Handle summary action
                            }
                            
                            Button("Save as Important") {
                                // Handle save as important action
                            }
                            
                            Button("Reply") {
                                // Handle reply action
                            }
                        }
                }
            }
            .padding(.top, -8)
            .padding(.bottom, -8)
            
            
            // Input area for typing messages
            HStack {
                TextField("Type a message", text: $actualPatientMessage)
                    .onChange(of: actualPatientMessage) { message in
                        handleUserMessageChange(message: message)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                
                Button(action: {
                    Task {
                        await sendMessage()
                    }
                }) {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
        } // vstack
        
    } // body
    
    private func sendMessage() async {
        if !actualPatientMessage.isEmpty {
            if let newMessage = await DuringConsultationVM.createMessage(message: actualPatientMessage, is_from_user: true, consultation_id: consultation_id) {
                
                webSocketManager.sendCompleteMessage(newMessage)
                actualPatientMessage = ""
                
                patientTimerStarted = false
                patientDebounceTimer?.invalidate()
            } else {
                print("Error al crear el mensaje")
            }
        }
    } // sendMessage
    
    func handleUserMessageChange(message: String) {
        if(!patientTimerStarted) {
            patientTimerStarted = true
            
            patientDebounceTimer?.invalidate()
            
            patientDebounceTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(patientWaitTime), repeats: false) { _ in
                // Enviar el mensaje actual
                self.webSocketManager.sendMessageBeingWrittenByUser(self.actualPatientMessage)
                // Restablecer el estado del temporizador
                self.patientTimerStarted = false
            }
        } // if
        
    } // handle Text change
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let webSocketManager = WebSocketManager()
        
        ChatView(webSocketManager: webSocketManager)
    }
}
