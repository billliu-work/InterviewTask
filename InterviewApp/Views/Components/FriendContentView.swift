//
//  FriendContentView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class FriendContentView: XibView {
    @IBOutlet weak var emptyView: EmptyFriendsView!
    @IBOutlet weak var searchBar: FriendsSearchBarView!
    @IBOutlet weak var friendList: FriendListView!
    @IBOutlet weak var chatView: ChatView!

    var tab: FriendsViewTab = .friends {
        didSet { updateVisibility() }
    }

    var friendsCount = 0

    override func commonInit() {
        updateVisibility(animated: false)
    }

    func updateFriends(visibleFriends: [Friend], friendsCount: Int) {
        friendList.friends = visibleFriends
        self.friendsCount = friendsCount
        updateVisibility()
    }

    private func updateVisibility(animated: Bool = true) {
        var showingViews = [UIView]()
        var hidingViews = [UIView]()
        switch tab {
        case .friends:
            if friendsCount == 0 {
                showingViews = [emptyView]
                hidingViews = [
                    searchBar,
                    friendList,
                    chatView,
                ]
            } else {
                showingViews = [
                    searchBar,
                    friendList,
                ]
                hidingViews = [
                    emptyView,
                    chatView,
                ]
            }
        case .chat:
            showingViews = [chatView]
            hidingViews = [
                emptyView,
                searchBar,
                friendList,
            ]
        }
        UIView.show(views: showingViews, isShowing: true, animated: animated)
        UIView.show(views: hidingViews, isShowing: false, animated: animated)
    }
}
