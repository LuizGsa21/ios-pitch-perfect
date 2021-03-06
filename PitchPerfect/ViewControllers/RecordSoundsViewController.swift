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


    // MARK: Outlets

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var centerLabel: UILabel!

    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        switchLabelsAndButtons(isRecording: false)
    }

    // MARK: Actions

    @IBAction func pressedRecordButton(_ sender: UIButton) {
        startRecording()
    }

    @IBAction func pressedStopButton(_ sender: UIButton) {
        stopRecording()
    }

    // MARK: UI States
    func switchLabelsAndButtons(isRecording: Bool) {
        centerLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recordButton.isEnabled = !isRecording
        stopButton.isEnabled = isRecording
    }

    // MARK: Audio
    func startRecording() {
        switchLabelsAndButtons(isRecording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func stopRecording() {
        switchLabelsAndButtons(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }


    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            performSegue(withIdentifier: "PlaySoundsViewController", sender: audioRecorder.url)
        } else {
            showAlert(PlaySoundsViewController.Alerts.RecordingFailedTitle, message: PlaySoundsViewController.Alerts.RecordingFailedMessage)
        }
    }

    // MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaySoundsViewController" {
            let controller = segue.destination as! PlaySoundsViewController
            controller.recordedAudioURL = sender as! URL;
        }
    }
}

