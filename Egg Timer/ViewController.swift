//
//  ViewController.swift
//  Egg Timer
//
//  Created by Nikolai Astakhov on 18.12.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var timerView: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let hardnessDict = ["Soft": 10, "Medium": 300, "Hard": 480]
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func hardnessButtonPressed(_ sender: UIButton) {
        var boilingTime = 0
        var timerTotalTime: Float = 0.0
        var timerPassedTime: Float = 0.0
        var progressBarPercentage: Float = 0.0
        
        titleView.text = sender.currentTitle!
        boilingTime = hardnessDict[sender.currentTitle!]!
        timerTotalTime = Float(hardnessDict[sender.currentTitle!]!)
        
        timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[self] _ in
                if boilingTime > 0 {
                    timerView.text = String(boilingTime)
                    boilingTime -= 1
                    
                    progressBarPercentage = (timerPassedTime / timerTotalTime)
                    progressView.progress = progressBarPercentage
                    timerPassedTime += 1
                } else {
                    timer.invalidate()
                    progressView.progress = 1.0
                    timerView.text = "Done!"
                    playSound()
                }
            }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "chicken", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
