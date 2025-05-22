//
//  FriendInvitationView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class FriendInvitationView: XibView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var portraitView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!

    var friend: Friend? {
        didSet {
            guard let name = friend?.name else { return }
            nameLabel.text = name
        }
    }

    var onAccepted: ((Friend) -> Void)?
    var onDeclined: ((Friend) -> Void)?

    override func commonInit() {
        portraitView.layer.cornerRadius = portraitView.bounds.size.width / 2
        backgroundView.layer.cornerRadius = 6
        backgroundView.clipsToBounds = true
    }

    @IBAction func onAcceptClicked(_ sender: UIButton) {
        guard let friend, let onAccepted else { return }
        Logger.info("FriendInvitationView - onAcceptClicked")
        onAccepted(friend)
    }

    @IBAction func onDeclineClicked(_ sender: UIButton) {
        guard let friend, let onDeclined else { return }
        Logger.info("FriendInvitationView - onDeclineClicked")
        onDeclined(friend)
    }
}
