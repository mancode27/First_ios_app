//
//  Audioplayer.swift
//  Restart_App
//
//  Created by Manojkumar Bellatti on 22/08/22.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type)
    // to specify the path of the audio file we want to play
    {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            // to play any selected sound file from the local app bundle
        }catch{
            print("Couldn't play the sound file")
        }
    }
}
