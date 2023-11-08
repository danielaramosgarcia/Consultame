//
//  TestWSView.swift
//  Consultame
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI
import SocketIO


struct TestWSView: View {
    @StateObject var webSocketManager = WebSocketManager()

    var body: some View {
        VStack {
            Text("Received messages from Node.js: ")
                .font(.title)
            Text("Messages count: \(webSocketManager.messages.count)")
                            .font(.subheadline)
            ForEach(webSocketManager.messages, id: \.id) { msg in
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
