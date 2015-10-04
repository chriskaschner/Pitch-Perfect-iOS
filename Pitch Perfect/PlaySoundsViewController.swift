//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Chris on 9/24/15.
//  Copyright (c) 2015 10LetterAcronym. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var rate:Float?
    var audioFile:AVAudioFile!
    
    func playAudio(rate: Float){
        //todo: create a function to simplify audio playback, pass in rate variable
        audioPlayer.prepareToPlay()
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.data
        audioPlayer.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
   
    try! audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
    audioPlayer.enableRate = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func stopAudioPlayback(sender: UIButton) {
        // stop audio playback
        audioPlayer.stop()
    }
    
    @IBAction func playFast(sender: UIButton) {
        // Play audio fast, , # in parantheses = rate of playback
        playAudio(2.0)
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
       
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
//        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
//        audioEngine.startAndReturnError(nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    @IBAction func playDarthAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func playSlow(sender: UIButton) {
        // Play audio slowly, # in parantheses = rate of playback
        playAudio(0.5)
    }
}
