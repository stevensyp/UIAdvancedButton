//
//  MainViewController.swift
//  UIAdvancedButtonExample
//  by Steven Syp
//

import UIKit
import UIAdvancedButtonFramework

class MainViewController: UIViewController {

    // MARK: IBOutlet Example
    @IBOutlet weak var fullButton: UIAdvancedButton!
    @IBAction func fullButtonAction(_ sender: Any) {
        print("fullButton tapped")
    }

    // MARK: Code Example
    lazy var mediumButton: UIAdvancedButton = {
        let button = UIAdvancedButton()
        button.set(colorStyle: .medium, contentLayout: .horizontalReversedSpaced)
        button.isContentBold = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tappedHandler = {
            print("mediumButton tapped")
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.addSubview(mediumButton)
        NSLayoutConstraint.activate([
            mediumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mediumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mediumButton.bottomAnchor.constraint(equalTo: fullButton.topAnchor, constant: -8)
        ])
    }

}

