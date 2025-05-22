//
//  FriendCell.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/21.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var portraitView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var ellipsisButton: UIButton!

    var friend: Friend? {
        didSet {
            guard let friend else { return }
            nameLabel.text = friend.name
            isTop = friend.isTop
        }
    }

    var isTop: Bool = false {
        didSet {
            starIcon.isHidden = !isTop
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        portraitView.layer.cornerRadius = portraitView.bounds.size.width / 2
        transferButton.layer.borderWidth = 1
        transferButton.layer.borderColor = UIColor(named: "colorPink")?.cgColor
        transferButton.layer.cornerRadius = 2
    }

    @IBAction func onTransferClicked(_ sender: UIButton) {
        Logger.info("FriendCell - onTransferClicked")
        Alert.showWorkInProgressAlert()
    }

    @IBAction func onEllipsisClicked(_ sender: UIButton) {
        Logger.info("FriendCell - onEllipsisClicked")
        Alert.showWorkInProgressAlert()
    }
}
