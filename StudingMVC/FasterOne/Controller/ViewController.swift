//
//  ViewController.swift
//  StudingMVC
//
//  Created by Сергей Цыганков on 10.06.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var value = Values()
    var justValue = Calculating()
    var timer = Timer()
    var time = 0.0 {
        didSet {
            timeLabel.text = "\(round(time*10)/10)"
        }
    }
    
    
    @IBOutlet weak var firstNumbLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var secondNumbLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var oneMistakeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGamePosition()
        
    }
    
    @IBAction func oneMistakeModeTapped(_ sender: UIButton) {
        value.modeIsOn = !value.modeIsOn
        setColor()
    }
    
    
    
    
    @IBAction func trueTapped(_ sender: UIButton) {
        value.answer = true
        tapped()
    }
    
    @IBAction func falseTapped(_ sender: UIButton) {
        value.answer = false
        tapped()
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        startEndGame()
    }
    //1
    private func tapped() {
        
        if justValue.makeCalculates(statment: value.answer) {
            value.score += 1
            scoreLabel.text = String(value.score)
        } else {
            if value.modeIsOn {
                startEndGame()
                endGame()
            }
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
    
    //MARK: - need to do
    private func setColor() {
        if value.modeIsOn == true {
            oneMistakeButton.tintColor = .red
            scoreLabel.tintColor = .red
        } else {
            oneMistakeButton.tintColor = .none
            scoreLabel.tintColor = .none
        }
    }
    
    
    private func endGame() {
        startButton.setTitle("Start", for: .normal)
        value.repeating = false
        scoreLabel.text = "Среднее время решения - \(round((time / Double(value.score)) * 10) / 10)"
        setTime()
        oneMistakeButton.isEnabled = true
        value.score = 0
    }
    
    private func startGamePosition() {
        
        firstNumbLabel.isHidden = !firstNumbLabel.isHidden
        signLabel.isHidden = !signLabel.isHidden
        secondNumbLabel.isHidden = !secondNumbLabel.isHidden
        falseButton.isHidden = !falseButton.isHidden
        trueButton.isHidden = !trueButton.isHidden
        
        if value.gamesDone < 3 {
            scoreLabel.isHidden = !scoreLabel.isHidden
            timeLabel.isHidden = !timeLabel.isHidden
        }
        
        if value.gamesDone % 2 == 0 {
            startButton.setTitle("Stop", for: .normal)
            value.repeating = true
            scoreLabel.text = "0"
            time = 0.0
            setTime()
            oneMistakeButton.isEnabled = false
        } else {
            endGame()
        }
        
        value.gamesDone += 1
    }
    //2
    private func startEndGame() {
        startGamePosition()
        justValue = setValues()
    }
    //3
    private func setTime() {
        
        timer = Timer.scheduledTimer(timeInterval: value.timeChange,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: value.repeating)
        
    }
    
    @objc private func tick() {
        
        if value.repeating {
            time += value.timeChange
        } else {
            timer.invalidate()
        }
    }
}

