//
//  voice.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 20/11/23.
//

import Foundation
import AVFoundation
import SwiftUI

struct voice: View {
    
    @State private var inputString = "Escribe aquí lo que quieras decir"
    @State var synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            TextField("Enter text", text: $inputString)
                .textFieldStyle(.roundedBorder)
            
            Button("Text to speech") {
                let utterance = AVSpeechUtterance(string: inputString)
                let voices = AVSpeechSynthesisVoice.speechVoices()
                 
                for voice in voices {
                    print(voice.identifier)
                }
                utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.es-MX.Paulina")
                utterance.pitchMultiplier = 1.2
                utterance.rate = 0.55
                synthesizer.speak(utterance)
            }
        }.padding()
        
    }
}

struct voice_Previews: PreviewProvider {
    static var previews: some View {
        voice()
    }
}
