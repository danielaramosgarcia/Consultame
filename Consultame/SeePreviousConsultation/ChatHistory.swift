//
//  ChatView.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import SwiftUI
import AVFoundation
import MediaPlayer

struct ChatHistory: View {
    
    @State private var actualPatientMessage = ""
    @State private var patientTimerStarted = false
    @State private var patientDebounceTimer: Timer?
    let waitTime = 3
    @ObservedObject var ChatMessages: ChatHistoryManager
    
    init (consultation_id: Int){
        ChatMessages = ChatHistoryManager(consultation_id: consultation_id)
        ChatMessages.getMessages()
    }
    
    
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
                    Text("Historial de Chat")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            
            // Chat messages
            
            if (ChatMessages.messagesArr.isEmpty){
                Spacer()
                Text("Esta cita no tiene mensajes")
                Spacer()
            } else {
                List {
                    ForEach(ChatMessages.messagesArr) { message in
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
                                    
                                }
                            }
                    }
                } // list
                .listStyle(PlainListStyle())
                
                .padding(.top, -8)
                .padding(.bottom, -8)
            }
        } // vstack
        
    } // body
}

struct ChatHistory_Previews: PreviewProvider {
    static var previews: some View {
        ChatHistory(consultation_id: 1)
    }
}
