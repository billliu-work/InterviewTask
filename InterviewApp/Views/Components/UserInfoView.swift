//
//  UserInfoView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class UserInfoView: XibView {
    @IBOutlet weak var portraitView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kokoidLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var user: User? {
        didSet {
            if let user {
                activityIndicator.stopAnimating()
                nameLabel.text = user.name
            } else {
                activityIndicator.startAnimating()
                nameLabel.text = ""
            }
            if let kokoid = user?.kokoid {
                kokoidLabel.text = "KOKO ID: \(kokoid)"
            } else {
                kokoidLabel.text = "設定 KOKO ID"
            }
        }
    }

    var onSetKokoid: (() -> Void)?

    override func commonInit() {
        portraitView.layer.cornerRadius = portraitView.bounds.size.width / 2

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onKokoidClicked))
        kokoidLabel.isUserInteractionEnabled = true
        kokoidLabel.addGestureRecognizer(tapGesture)
    }

    @objc func onKokoidClicked() {
        onSetKokoid?()
    }
}
