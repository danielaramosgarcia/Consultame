//
//  Chat.swift
//  Consultame
//
//  Created by admin on 10/11/23.
//

import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var content: String
    var isUser: Bool
}

struct ContentView: View {
    @State private var messages = [
        Message(content: "Buenos días señor Ramírez! Rápidamente le comento que el día de hoy lo que le vamos a realizar es un chequeo de sangre para revisar sus plaquetas, como bien usted...", isUser: false),
        Message(content: "¿Qué son las plaquetas?", isUser: true),
        Message(content: "Una disculpa, claro, digamos que las plaquetas son parte de nuestra sangre y nos ayudan justo a producir coágulos sanguíneos, justo por eso necesitamos sacarle sangre, para ver sus niveles...", isUser: false),
        Message(content: "¿Cómo me la sacarán?", isUser: true),
        Message(content: "Usted no se preocupe por nada, solo tiene que ir a la sección del hospital llamada Laboratorio y ahí una señorita le sacará un poco de sangre con una jeringa especializada, es probable que primero toque su brazo y lo acomode, no tiene de qué preocuparse, es parte del proceso.", isUser: false),
        // Add more messages as needed
    ]

    @State private var isPlaying = false
    @State private var newMessage = ""

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
                    ForEach(messages) { message in
                        MessageRow(message: message)
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
                    Button(action: {
                        // Handle record/play/pause button action
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.blue)
                            .padding(8)
                    }

                    TextField("Type a message", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(8)

                    Button(action: {
                        // Handle send button action
                        sendMessage()
                    }) {
                        Text("Send")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
    }

    private func sendMessage() {
        if !newMessage.isEmpty {
            let message = Message(content: newMessage, isUser: true)
            messages.append(message)
            newMessage = ""
        }
    }
}

struct MessageRow: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

