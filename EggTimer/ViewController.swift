//
//  ViewController.swift
//  EggTimer
//
//  Created by Mateusz Urbas on 07/11/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var progressBar: UIProgressView!
        
    var player: AVAudioPlayer!
    var timer = Timer()

    var totalTime = 0;
    var secondsPassed = 0;
    
    let eggTimes = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7
    ]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        player?.stop()
        timer.invalidate()
        
        let hardness = sender.currentTitle!;
        
        label.text = hardness
        progressBar.progress = 0
        totalTime = eggTimes[hardness]!
        secondsPassed = 0

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed+=1
            let progress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = progress
        } else {
            timer.invalidate()
            label.text = "DONE!"
            playAlarm()
        }
    }
    
    func playAlarm() {
        let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3")
        let url = URL(fileURLWithPath: path!)
        player = try! AVAudioPlayer(contentsOf: url);
        player?.play()
    }
}

