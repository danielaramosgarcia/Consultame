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
    
    var messageManager: MessageManager
        var duringConsultationVM: DuringConsultationViewModel
    var webSocketManager: WebSocketManager
    
    @State private var actualPatientMessage = ""
    @State private var patientTimerStarted = false
    @State private var patientDebounceTimer: Timer?
    let waitTime = 1
    
    @State private var forcedSent = false
    
    @State var synthesizerDelegate = SpeechSynthesizerDelegate()
    @State var synthesizer = AVSpeechSynthesizer()
    
    
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
                    synthesizer.delegate = synthesizerDelegate
                                        synthesizerDelegate.onDidFinish = {
                                            speechRecognizer.transcribe()
                                        }
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
                ForEach(messageManager.messages) { message in
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
                                Task {
                                    if let newMessage = await self.duringConsultationVM.createMessage(message: speechRecognizer.transcript, is_from_user: false, consultation_id: self.webSocketManager.consultationID) {
                                        self.webSocketManager.sendCompleteMessage(newMessage)
                                        speechRecognizer.stopTranscribing()
                                        let utterance = AVSpeechUtterance(string: message.message)
                                        
                                        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.es-MX.Paulina")
                                        utterance.pitchMultiplier = 1.2
                                        utterance.rate = 0.55
                                        synthesizer.speak(utterance)
                                        forcedSent = true
                                    } else {
                                        print("Error al crear el mensaje")
                                    }
                                }
                                

                            }
                        }
                }
                MessageFromDoctorView(
                    DuringConsultationVM: duringConsultationVM,
                    
                    webSocketManager: webSocketManager,
                    waitTime: waitTime,
                    speechRecognizer: speechRecognizer,
                    forcedSent: $forcedSent
                )
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
            if let newMessage = await duringConsultationVM.createMessage(message: actualPatientMessage, is_from_user: true, consultation_id: webSocketManager.consultationID) {
                
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
        // Crear instancias de las dependencias requeridas por ChatView
                let messageManager = MessageManager()
                let duringConsultationVM = DuringConsultationViewModel(messageManager: messageManager)
                let webSocketManager = WebSocketManager(consultationID: 1, messageManager: messageManager)

                // Inicializar ChatView con las dependencias
                ChatView(messageManager: messageManager, duringConsultationVM: duringConsultationVM, webSocketManager: webSocketManager)
    }
}
