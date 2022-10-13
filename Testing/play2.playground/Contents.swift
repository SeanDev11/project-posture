import UIKit
import AVFoundation
import Foundation

var utterance = AVSpeechUtterance()
let synthesizer = AVSpeechSynthesizer()
let voice = AVSpeechSynthesisVoice(identifier: "en-US")

utterance.voice = voice


let timer = Timer()

Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(talk), userInfo: nil, repeats: false)


func talk() {
    
    
    
}
