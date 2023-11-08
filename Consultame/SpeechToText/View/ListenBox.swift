//
//  ListenBox.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 06/11/23.
//

import SwiftUI

struct ListenBox: View {
//    @Binding var datos: DatosConsulta
//    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16.0)
                .stroke(Color.gray, lineWidth: 2)
                .accentColor(.gray)
            VStack{
                Text("Aquí veras la transcipción")
                Spacer()
                HStack{
                    CircleButton(icon: "mic", colorString: "53d769")
                        
                    CircleButton(icon: "pause.fill", colorString: "FFFFF")
                    
                    CircleButton(icon: "stop.fill", colorString: "fc3d39")
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

struct ListenBox_Previews: PreviewProvider {
    static var previews: some View {
//        ListenBox(datos: .constant(DatosConsulta.sampleData[0]))
        ListenBox()
    }
}
