//
//  TestWSView.swift
//  Consultame
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI
import SocketIO

final class Service : ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: API.baseURL)!, config: [.log(true), .compress])
    @Published var messages = [(id: UUID, msg: String)]()
    
    init() {
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Connected")
            socket.emit("NodeJS Server Port", "Hi Node.JS server")
        }
        
        socket.on("iOS Client Port") { (data, ack) in
            if let data = data[0] as? [String: String],
               let rawMessage = data["msg"] {
                DispatchQueue.main.async {
                    self.messages.append((id: UUID(), msg: rawMessage))
                }
                
            }
        }
        socket.connect()
    } // init
    
}

struct TestWSView: View {
    @StateObject var service = Service()
    
    var body: some View {
        VStack {
            Text("Received messages from Node.js: ")
                .font(.title)
            Text("Messages count: \(service.messages.count)")
                            .font(.subheadline)
            ForEach(service.messages, id: \.id) { msg in
                Text(msg.msg)
                    .padding()
            }
            
            
            Spacer()
        } // vstack
    } // body
}

struct TestWSView_Previews: PreviewProvider {
    static var previews: some View {
        TestWSView()
    }
}
