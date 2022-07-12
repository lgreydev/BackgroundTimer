//
//  ViewController.swift
//  BackgroundTimer
//
//  Created by Sergey Lukaschuk on 12.07.2022.
//

import UIKit
//import AloeStackView
import TinyConstraints

class ViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = UIFont.systemFont(ofSize: 30.0)
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        return button
    }()

    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.addTarget(self, action: #selector(tapResetButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        addRows()
    }
}


private extension ViewController {
    func addRows() {
        do {
            view.addSubview(label)
            label.topToSuperview(offset: 100)
            label.centerXToSuperview()
        }

        do {
            view.addSubview(startButton)
            startButton.bottom(to: label, offset: 50)
            startButton.leadingToSuperview(offset: 50)
        }

        do {
            view.addSubview(resetButton)
            resetButton.bottom(to: label, offset: 50)
            resetButton.trailingToSuperview(offset: 50)
        }
    }

    @objc func tapStartButton() {
        print(#function)
    }

    @objc func tapResetButton() {
        print(#function)
    }
}
