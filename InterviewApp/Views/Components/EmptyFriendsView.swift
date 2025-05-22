//
//  EmptyFriendsView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class EmptyFriendsView: XibView {
    @IBOutlet weak var illustrationView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var footerLabel: UILabel!

    var onAddFriend: (() -> Void)?
    var onSetKokoid: (() -> Void)?

    private var linkRange: NSRange = NSMakeRange(0, 0)

    override func commonInit() {
        let attributedString = NSMutableAttributedString(string: "幫助好友更快找到你？設定 KOKO ID")
        linkRange = NSMakeRange(10, 10)
        var attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single,
        ]
        if let color = UIColor(named: "colorPink") {
            attributes[.foregroundColor] = color
        }
        attributedString.setAttributes(attributes, range: linkRange)
        footerLabel.attributedText = attributedString
        footerLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFooterTap))
        footerLabel.addGestureRecognizer(tapGesture)
    }

    @IBAction func onAddFriendClicked(_ sender: UIButton) {
        Logger.info("EmptyFriendsCell - onAddFriendClicked")
        onAddFriend?()
    }

    @objc func handleFooterTap(_ gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: footerLabel, inRange: linkRange) {
            Logger.info("EmptyFriendsCell - clicked on set KOKO ID")
            onSetKokoid?()
        }
    }
}
