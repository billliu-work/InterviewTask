//
//  FriendInvitationListView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class FriendInvitationListView: UIView {
    var friends: [Friend] = [] {
        didSet { updateInvitationViews() }
    }

    var isCollapsed = false
    var onConfiguringView: ((FriendInvitationView) -> Void)?

    private var containerView: CollapsibleContainerView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let containerView = CollapsibleContainerView(frame: bounds)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.containerView = containerView
        containerView.layoutAttachAll()
    }

    private func updateInvitationViews() {
        var difference = friends.count - containerView.collapsibleViews.count
        if difference > 0 {
            let rect = CGRect(origin: .zero, size: .init(width: self.bounds.size.width - 60, height: 70))
            for _ in 0..<difference {
                let invitationView = FriendInvitationView(frame: rect)
                containerView.addCollapsibleView(invitationView, layout: false)
            }
        } else if difference < 0 {
            difference = -difference
            for _ in 0..<difference {
                guard let last = containerView.collapsibleViews.last else { return }
                containerView.removeCollapsibleView(last, layout: false)
            }
        }
        for i in 0..<friends.count {
            if i < containerView.collapsibleViews.count,
               let invitationView = containerView.collapsibleViews[i] as? FriendInvitationView {
                invitationView.friend = friends[i]
                onConfiguringView?(invitationView)
            }
        }
        containerView.updateLayout()
    }
}
