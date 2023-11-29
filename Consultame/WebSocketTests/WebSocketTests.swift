//
//  WebSocketTests.swift
//  Consultame
//
//  Created by Alumno on 19/11/23.
//

import SwiftUI

struct WebSocketTests: View {
    var webSocketManager: WebSocketManager
    
    
    var body: some View {
        VStack {
            SpeechToTextTestView(webSocketManager: webSocketManager)
            
            TextToSpeechTestView(webSocketManager: webSocketManager)
        }
    }
}

struct WebSocketTests_Previews: PreviewProvider {
    static var previews: some View {
        let webSocketManager = WebSocketManager(consultationID: 1)

        WebSocketTests(webSocketManager: webSocketManager)
    }
}
