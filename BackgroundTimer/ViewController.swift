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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        addRows()
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

    @objc func startStopAction() {
        print(#function)
    }

    @objc func resetAction() {
        print(#function)
    }
}
