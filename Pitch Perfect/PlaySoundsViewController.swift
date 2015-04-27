//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Steven Marlowe on 4/7/15.
//  Copyright (c) 2015 Steven Marlowe. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine = AVAudioEngine()
    var audioFile: AVAudioFile!
    
    @IBAction func playSlow(sender: AnyObject)
    {
        audioEngine.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
        
        println("Play slow")
    }
    
    
    @IBAction func playFast(sender: AnyObject)
    {
        
        audioEngine.stop()
        audioPlayer.rate = 1.5
        audioPlayer.play()
        
    }

    @IBAction func playChipmunkAudio(sender: AnyObject)
    {
        playAudioWithVariablePitch(1000)
        
    }
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        println("Playing with variable")
        audioPlayer.stop()
        audioEngine.stop()
        var pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        audioEngine.attachNode(pitchPlayer)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    }
    
    @IBAction func playDarthVaderAudio(sender: AnyObject)
    {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func stop(sender: AnyObject)
    {
        audioPlayer.stop()
          audioEngine.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
    audioPlayer.enableRate = true
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
}
}
