//
//  SpeechSynthesizerDelegate.swift
//  Consultame
//
//  Created by Alumno on 28/11/23.
//

import Foundation
import AVFoundation

class SpeechSynthesizerDelegate: NSObject, AVSpeechSynthesizerDelegate {
    var onDidFinish: (() -> Void)?

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        onDidFinish?()
    }
}
