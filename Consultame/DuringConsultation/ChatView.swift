//
//  ChatView.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import SwiftUI
import AVFoundation
import MediaPlayer

struct ChatView: View {
    var webSocketManager: WebSocketManager
    @StateObject var DuringConsultationVM = DuringConsultationViewModel()
    
    @State private var actualPatientMessage = ""
    @State private var patientTimerStarted = false
    @State private var patientDebounceTimer: Timer?
    let waitTime = 3
    
    @State var synthesizer = AVSpeechSynthesizer()
    
    let consultation_id = 1 // obtenerlo al darle click a la consulta especifica
    
    // speech to text
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var player: AVPlayer = AVPlayer.sharedDingPlayer
    
    
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
                .onAppear {
                    // Iniciar la reproducción de audio
                    player.seek(to: .zero)
                    player.play()
                    
                    // Iniciar la transcripción de voz
                    speechRecognizer.stopTranscribing()
                    speechRecognizer.transcribe()
                }
                .onDisappear{
                    speechRecognizer.stopTranscribing()
                }
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            
            // Chat messages
            List {
                ForEach(DuringConsultationVM.messagesArr) { message in
                    MessageRowView(message: message)
                        .listRowSeparator(.hidden)
                        .contextMenu {
                            Button("Summary") {
                                
                            }
                            
                            Button("Save as Important") {
                                // Handle save as important action
                            }
                            
                            Button("Reply") {
                                // Handle reply action
                            }
                            
                            Button("Text to Speech") {
                                let utterance = AVSpeechUtterance(string: message.message)
                                
                                utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.es-MX.Paulina")
                                utterance.pitchMultiplier = 1.2
                                utterance.rate = 0.55
                                synthesizer.speak(utterance)
                            }
                        }
                }
                MessageFromDoctorView(
                    DuringConsultationVM: DuringConsultationVM,
                    consultation_id: consultation_id,
                    webSocketManager: webSocketManager,
                    waitTime: waitTime,
                    speechRecognizer: speechRecognizer)
                .listRowSeparator(.hidden)
            } // list
            .listStyle(PlainListStyle())
            
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
        if(!patientTimerStarted && !actualPatientMessage.isEmpty) {
            patientTimerStarted = true
            
            patientDebounceTimer?.invalidate()
            
            patientDebounceTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(waitTime), repeats: false) { _ in
                // Enviar el mensaje actual
                self.webSocketManager.sendMessageBeingWritten(message: self.actualPatientMessage, is_from_user: true)
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
