//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Luiz Arantes Sa on 11/5/17.
//  Copyright © 2017 Luiz Arantes Sa. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var centerLabel: UILabel!

    override func viewDidLoad() {
        setDefaultState()
    }

    @IBAction func pressedRecordButton(_ sender: UIButton) {
        startRecording()
    }

    @IBAction func pressedStopButton(_ sender: UIButton) {
        stopRecording()
    }

    func setDefaultState() {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        centerLabel.text = "Tap to Record!"
    }

    func setRecordingState() {
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        centerLabel.text = "Recording in Progress"
    }

    func startRecording() {
        setRecordingState()
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

    }

    func stopRecording() {
        setDefaultState()
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }


    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {

    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            performSegue(withIdentifier: "PlaySoundsViewController", sender: audioRecorder.url)
        } else {
            // TODO: show alert
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaySoundsViewController" {
            let controller = segue.destination as! PlaySoundsViewController
            controller.recordedAudioURL = sender as! URL;
        }
    }
}

