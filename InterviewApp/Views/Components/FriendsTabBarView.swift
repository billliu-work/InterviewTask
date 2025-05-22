//
//  FriendsTabBarView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class FriendsTabBarView: XibView {
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var friendsBadge: NumberBadge!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var chatBadge: NumberBadge!
    @IBOutlet weak var bar: UIView!

    var invitationCount: Int = 0 {
        didSet {
            friendsBadge.value = invitationCount
        }
    }

    var chatCount: Int = 0 {
        didSet {
            chatBadge.value = chatCount
        }
    }

    var onTabSelected: ((FriendsViewTab) -> Void)?

    @IBAction func onFriendsClicked(_ sender: UIButton) {
        Logger.info("FriendsTabBarCell - onFriendsClicked")
        animateBar(friendsButton.frame.midX) { [weak self] in
            self?.onTabSelected?(.friends)
        }
    }

    @IBAction func onChatClicked(_ sender: UIButton) {
        Logger.info("FriendsTabBarCell - onChatClicked")
        animateBar(chatButton.frame.midX) { [weak self] in
            self?.onTabSelected?(.chat)
        }
    }

    private func animateBar(_ x: CGFloat, onCompletion: @escaping () -> Void) {
        var barFrame = bar.frame
        barFrame.origin.x = x - barFrame.size.width / 2
        barFrame.origin.y = bounds.size.height - barFrame.size.height
        UIView.animate(withDuration: 0.1) {
            self.bar.frame = barFrame
        } completion: { _ in
            onCompletion()
        }
    }
}
