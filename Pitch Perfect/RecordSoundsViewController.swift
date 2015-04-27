//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Steven Marlowe on 4/5/15.
//  Copyright (c) 2015 Steven Marlowe. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
{
    var recording = false
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    @IBOutlet weak var mic: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    @IBAction func recordAudio(sender: UIButton)
    {
  
        println("Recording voice")
        
    
        if !recording
        {
            setRecording()
        }
        else
        {
           // stopRecording()
        }
        
        
        
    }

    @IBAction func stopButtonPress(sender: UIButton)
    {
        stopRecording()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

     override func viewWillAppear(animated: Bool)
    {
        stopRecording()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setRecording()
    {
        tapLabel.hidden = true
        stopButton.hidden = false
        recordingLabel.hidden = false
        mic.enabled = false
        recording = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        println("Dirpath")
        println(dirPath)
        
        var currentDateTime = NSDate()
        println(currentDateTime)
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        println(recordingName)
        var pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // Initialize and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func stopRecording()
    {
        tapLabel.hidden = false
        stopButton.hidden = true
        recordingLabel.hidden = true
        mic.enabled = true
        recording = false
       
        if (audioRecorder != nil)
        {
            audioRecorder.stop()
        }
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        if (flag)
        {
            println("Recording successfully stopped.")
            recordedAudio = RecordedAudio(url: recorder.url, titleIn: recorder.url.lastPathComponent!)
            
        
        performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("Error in recording")
            stopRecording()
        
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
            if (segue.identifier == "stopRecording")
            {
                let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
                playSoundsVC.receivedAudio = sender as! RecordedAudio
            }
    }
}

