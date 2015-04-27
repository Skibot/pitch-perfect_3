
//
//  PlaySoundsViewController.swift
//  Pitch-Perfect
//
//  Created by Donald Hurd on 4/5/15.
//  Copyright (c) 2015 DonHurdApps. All rights reserved.
//
//  This code controls 5 button on the 2nd page of the UI, & connects
//  each button to the corresponding 4 sound effect: slow, fast, high
//  pitch, & low pitch; or just stops the playback.

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    // Define audioPlayer & receivedAudio (unwrapped)
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    // Define audioEngine & audioFile (unwrapped)
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset audioPlayer
    func playSelectedAudio(rates: Float){
        audioPlayer.enableRate = true
        resetAudioPlayerAndEngine()
        audioPlayer.rate = rates
        audioPlayer.currentTime = 0.0
        audioPlayer.play()

    }
    
    // playDarthVader sound effect with fairly low pitch
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-700)
    }
    
    // playChipmunkAudio sound effect with fairly high pitch
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1200)
    }
    
    // Reset audioPlayer & audioEngine
    func resetAudioPlayerAndEngine() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

    }
    
    
        func playAudioWithVariablePitch(pitch: Float){
            resetAudioPlayerAndEngine()

        // Define audioPlayerNode & attach to audioEngine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // Define changePitchEffect & connect to audioEngine & play selected pitch effect
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)

        
        audioPlayerNode.play()
    
    }
    // Stop audioPlayer
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()  
        
    }
   
    // Playback audioPlayer at high speed
    @IBAction func fastPlay(sender: UIButton) {
       playSelectedAudio(2.0)
    }
    
    // Playback audioPlayer at low speed
    @IBAction func PlaySlow(sender: UIButton) {
        playSelectedAudio(0.5)
    }

}
