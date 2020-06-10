//
//  ViewController.swift
//  StudingMVC
//
//  Created by Сергей Цыганков on 10.06.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var (gamesDone, score) = (1, 0)
    var (answer, repeating) = (false, false)
    var justValue = Calculating()
    var timer = Timer()
    var time = 0.0 {
        didSet {
            timeLabel.text = "\(round(time*10)/10)"
        }
    }
    var timeChange = 0.1
    
    @IBOutlet weak var firstNumbLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var secondNumbLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGamePosition()
        
        
    }
    
    @IBAction func trueTapped(_ sender: UIButton) {
        answer = true
        tapped()
    }
    
    @IBAction func falseTapped(_ sender: UIButton) {
        answer = false
        tapped()
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        startGamePosition()
        justValue = setValues()
    }
    
    private func tapped() {
        
        if justValue.makeCalculates(statment: answer) {
            score += 1
            scoreLabel.text = String(score)
        }
        
        justValue = setValues()
        
        
    }
    
    private func setValues() -> Calculating {
        let calculating = Calculating()
        firstNumbLabel.text = String(calculating.elements.numberOne)
        signLabel.text =
            String(calculating.signs[Int(calculating.elements.arrayOfSignsPosition)])
        secondNumbLabel.text = String(calculating.elements.secondOne)
        return calculating
    }
    
    private func startGamePosition() {
        firstNumbLabel.isHidden = !firstNumbLabel.isHidden
        signLabel.isHidden = !signLabel.isHidden
        secondNumbLabel.isHidden = !secondNumbLabel.isHidden
        falseButton.isHidden = !falseButton.isHidden
        trueButton.isHidden = !trueButton.isHidden
        
        if gamesDone < 3 {
            scoreLabel.isHidden = !scoreLabel.isHidden
            timeLabel.isHidden = !timeLabel.isHidden
        }
        
        if gamesDone % 2 == 0 {
            startButton.setTitle("Start", for: .normal)
            repeating = true
            scoreLabel.text = "0"
            time = 0.0
            setTime()
        } else {
            startButton.setTitle("Stop", for: .normal)
            repeating = false
            setTime()
        }
        
        gamesDone += 1
    }
    
    private func setTime() {
        
        timer = Timer.scheduledTimer(timeInterval: timeChange,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: repeating)
        
    }
    
    @objc private func tick() {
        
        if repeating {
            time += timeChange
        } else {
            timer.invalidate()
        }
    }
}

