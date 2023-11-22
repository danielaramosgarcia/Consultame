//
//  transcripcion.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 19/11/23.
//

import SwiftUI
import AVFoundation
import MediaPlayer

struct transcripcion: View {
  
  @State var textValue: String = "The transcription text"
  @StateObject var speechRecognizer = SpeechRecognizer()
  
  private var player: AVPlayer { AVPlayer.sharedDingPlayer }
  
    var body: some View {
        VStack {
            Image(systemName: "mic")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(speechRecognizer.transcript)
                .font(.title)
            Text("hola")
          HStack(spacing: 64) {
            Button {
            
              print("starting")
              self.textValue = "New Text"
              
            
              player.seek(to: .zero)
              player.play()

              speechRecognizer.reset()
              speechRecognizer.transcribe()

            } label: {
              Text("Start")
            }
            Button {
              print("Stop")
              
              speechRecognizer.stopTranscribing()
              print(speechRecognizer.transcript)
            } label: {
              Text("Stopping")
            }

          }
        }
        .padding()
    }
}


struct transcripcion_Previews: PreviewProvider {
    static var previews: some View {
        transcripcion()
    }
}
