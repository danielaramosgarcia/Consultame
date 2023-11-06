//
//  ListenBox.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 06/11/23.
//

import SwiftUI

struct SpeakBox: View {
//    @Binding var datos: DatosConsulta
//    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16.0)
                .stroke(Color.gray, lineWidth: 2)
                .accentColor(.gray)
            VStack{
                Text("Escribe lo que quieras que se convierta a voz")
                Spacer()
                HStack{
                    CircleButton(icon: "play.fill", colorString: "53d769")
                        
                    CircleButton(icon: "stop.fill", colorString: "FFFFF")
                    
                    CircleButton(icon: "trash.fill", colorString: "fc3d39")
                }
            }
            .padding(10)
        }
        
    }
//    private func startScrum() {
//        speechRecognizer.resetTranscript()
//        speechRecognizer.startTranscribing()
//        isRecording = true
//    }
//    private func endScrum() {
//        speechRecognizer.stopTranscribing()
//        isRecording = false
//        let newHistory = History(transcript: speechRecognizer.transcript)
//        datos.history.insert(newHistory, at: 0)
//    }

}

struct Speak_Previews: PreviewProvider {
    static var previews: some View {
//        ListenBox(datos: .constant(DatosConsulta.sampleData[0]))
        SpeakBox()
    }
}
