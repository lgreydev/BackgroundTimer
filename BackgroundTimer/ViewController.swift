//
//  ViewController.swift
//  BackgroundTimer
//
//  Created by Sergey Lukaschuk on 12.07.2022.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = UIFont.systemFont(ofSize: 30.0)
        return label
    }()

    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.addTarget(self, action: #selector(startStopAction), for: .touchUpInside)
        return button
    }()

    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        return button
    }()

    var timerCounting: Bool = false

    var startTime: Date?
    var stopTime: Date?

    let userDefaults = UserDefaults.standard

    let START_TIME_KEY = "startTime"
    let STOP_TIME_KEY = "stopTime"
    let COUNTING_KEY = "countingKey"

    var scheduledTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        addRows()

        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
    }
}

private extension ViewController {
    func addRows() {
        do {
            view.addSubview(timeLabel)
            timeLabel.topToSuperview(offset: 100)
            timeLabel.centerXToSuperview()
        }

        do {
            view.addSubview(startStopButton)
            startStopButton.bottom(to: timeLabel, offset: 50)
            startStopButton.leadingToSuperview(offset: 50)
        }

        do {
            view.addSubview(resetButton)
            resetButton.bottom(to: timeLabel, offset: 50)
            resetButton.trailingToSuperview(offset: 50)
        }
    }



    func setStartTime(date: Date?) {
        startTime = date
        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }

    func setStopTime(date: Date?) {
        stopTime = date
        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }

    func setTimerCounting(_ value: Bool) {
        timerCounting = value
        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
    }

    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
        startStopButton.setTitle("STOP", for: .normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }

    func stopTimer() {

        if scheduledTimer != nil {
            scheduledTimer.invalidate()
        }

        setTimerCounting(false)
        startStopButton.setTitle("START", for: .normal)
        startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
    }

    @objc func startStopAction() {
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
        } else {
            startTimer()
        }
    }

    @objc func resetAction() {
        print(#function)
    }

    @objc func  refreshValue() {

    }
}
