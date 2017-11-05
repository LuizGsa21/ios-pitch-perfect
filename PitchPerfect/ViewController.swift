//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Luiz Arantes Sa on 11/5/17.
//  Copyright © 2017 Luiz Arantes Sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var centerLabel: UILabel!
    
    override func viewDidLoad() {
        setDefaultState()
    }
    
    @IBAction func pressedRecordButton(_ sender: UIButton) {
        setRecordingState()
    }
    
    @IBAction func pressedStopButton(_ sender: UIButton) {
        setDefaultState()
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
    
}

