//
//  WordMethods.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation
import AVFoundation

extension ViewModel {
    
    
    func textToSpeech(_ text: String) {
        
        // https://developer.apple.com/documentation/avfoundation/speech-synthesis
        let utterance = AVSpeechUtterance(string: text)
        
//        utterance.rate = 0.57
//        utterance.pitchMultiplier = 0.8
//        utterance.postUtteranceDelay = 0.2
//        utterance.volume = 1
        
       // let voice = AVSpeechSynthesisVoice(language: "en-GB")
        
       // utterance.voice = voice
        
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterance)
//        print("\(utterance)")
//       // print("\(voice)")
//        print("\(synthesizer)")
    }
}
