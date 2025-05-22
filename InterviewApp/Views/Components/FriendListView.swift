//
//  FriendListView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class FriendListView: XibView {
    @IBOutlet weak var tableView: UITableView!

    var friends: [Friend] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func commonInit() {
        tableView.registerCell("FriendCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension FriendListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell {
            cell.friend = friend
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
}

// MARK: - UITableViewDelegate

extension FriendListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
