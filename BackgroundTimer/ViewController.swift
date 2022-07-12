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

        view.backgroundColor = .cyan

        addRows()

        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        timerCounting = userDefaults.bool(forKey: COUNTING_KEY)

        if timerCounting {
            startTimer()
        } else {
            stopTimer()
            if let start = startTime {
                if let stop = stopTime {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
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

    func setTimeLabel(_ value: Int) {
        let time = secondsToHoursMinutesSeconds(value)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timeLabel.text = timeString
    }

    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }

    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""

        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        timeString += ":"

        return timeString
    }

    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }

    @objc func startStopAction() {
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
        } else {
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            startTimer()
        }
    }

    @objc func resetAction() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        timeLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
        stopTimer()
    }

    @objc func  refreshValue() {
        if let start = startTime {
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }
}
