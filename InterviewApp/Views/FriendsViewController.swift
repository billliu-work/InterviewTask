//
//  FriendsViewController.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import Combine
import UIKit

enum FriendsViewTab {
    case friends
    case chat
}

@MainActor
class FriendsViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var userInfoView: UserInfoView!
    @IBOutlet weak var friendInvitationListView: FriendInvitationListView!
    @IBOutlet weak var friendsTabBarView: FriendsTabBarView!
    @IBOutlet weak var friendContentView: FriendContentView!

    private let viewModel = FriendsViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var isLoading = false
    private var collapseInvitation = false
    private var isSearching = false
    private var searchText = ""

    private var invitations: [Friend] = []
    private var activeFriends: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupComponents()
        subscribeToChanges()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onReload), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "colorPink")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "colorWhiteTwo")
        viewModel.loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = nil
    }
}

// MARK: - Private

private extension FriendsViewController {
    @objc func onReload() {
        viewModel.loadData(reload: true) { [weak self] in
            self?.scrollView.refreshControl?.endRefreshing()
        }
    }

    @objc func onWithdrawClicked(_ sender: UIButton) {
        Logger.info("OldFriendsViewController - onWithdrawClicked")
        Alert.showWorkInProgressAlert()
    }

    @objc func onTransferClicked(_ sender: UIButton) {
        Logger.info("OldFriendsViewController - onTransferClicked")
        Alert.showWorkInProgressAlert()
    }

    @objc func onScanClicked(_ sender: UIButton) {
        Logger.info("OldFriendsViewController - onScanClicked")
        Alert.showWorkInProgressAlert()
    }

    func subscribeToChanges() {
        viewModel.$user
            .sink { [weak self] in
                self?.userInfoView.user = $0
            }
            .store(in: &subscriptions)
        
        viewModel.$friends
            .sink { [weak self] in
                self?.handleFriendsUpdate($0)
            }
            .store(in: &subscriptions)
    }

    func setupNavigationItems() {
        let withdrawItem = UIBarButtonItem(image: UIImage(named: "icNavPinkWithdraw"), style: .plain, target: self, action: #selector(onWithdrawClicked))
        let transferItem = UIBarButtonItem(image: UIImage(named: "icNavPinkTransfer"), style: .plain, target: self, action: #selector(onTransferClicked))
        let scanItem = UIBarButtonItem(image: UIImage(named: "icNavPinkScan"), style: .plain, target: self, action: #selector(onScanClicked))
        navigationItem.leftBarButtonItems = [withdrawItem, transferItem]
        navigationItem.rightBarButtonItem = scanItem
    }

    func setupComponents() {
        // userInfoView
        userInfoView.onSetKokoid = { [weak self] in
            self?.showSetKokoid()
        }

        // friendInvitationListView
        friendInvitationListView.onConfiguringView = { [weak self] invitationView in
            guard let self else { return }
            invitationView.onAccepted = { [weak self] in
                self?.viewModel.acceptInvitation($0)
            }
            invitationView.onDeclined = { [weak self] in
                self?.viewModel.declineInvitation($0)
            }
        }

        // friendsTabBarView
        friendsTabBarView.onTabSelected = { [weak self] in
            self?.friendContentView.tab = $0
        }

        // friendContentView (searchBar)
        friendContentView.searchBar.onAddFriend = { [weak self] in
            self?.addNewFriend()
        }
        friendContentView.searchBar.onSearchStateChange = { [weak self] in
            guard let self else { return }
            switch $0 {
            case .none:
                isSearching = false
                searchText = ""
            case .searching(let text):
                isSearching = true
                searchText = text
            }
            updateSearchState()
        }

        // friendContentView (searchBar)
        friendContentView.emptyView.onAddFriend = { [weak self] in
            self?.addNewFriend()
        }
        friendContentView.emptyView.onSetKokoid = { [weak self] in
            self?.showSetKokoid()
        }
    }

    func addNewFriend() {
        Logger.debug("OldFriendsViewController - addNewFriend")
        Alert.showWorkInProgressAlert()
    }

    func showSetKokoid() {
        guard let viewController = UIStoryboard.viewController("SetKokoidViewController") else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }

    func handleFriendsUpdate(_ friends: [Friend]) {
        let invitations = friends.filter { $0.status == .invitationSent && !$0.declined }
        let activeFriends = friends.filter { $0.status != .invitationSent }

        self.invitations = invitations
        self.activeFriends = activeFriends

        friendInvitationListView.friends = invitations

        friendsTabBarView.invitationCount = invitations.count
        friendsTabBarView.chatCount = activeFriends.count > 0 ? 100 : 0

        updateSearchState()
    }

    func updateSearchState() {
        var showingViews = [UIView]()
        var hidingViews = [UIView]()

        if isSearching {
            hidingViews = [
                userInfoView,
                friendInvitationListView,
                friendsTabBarView,
            ]
        } else {
            showingViews = [
                userInfoView,
                friendsTabBarView,
            ]
            if invitations.isEmpty {
                hidingViews = [friendInvitationListView]
            } else {
                showingViews.append(friendInvitationListView)
            }
        }

        UIView.show(views: showingViews, isShowing: true, animated: true)
        UIView.show(views: hidingViews, isShowing: false, animated: true)
        
        let friends: [Friend]
        if isSearching, !searchText.isEmpty {
            friends = activeFriends.filter { $0.name.contains(searchText) }
        } else {
            friends = activeFriends
        }
        friendContentView.updateFriends(visibleFriends: friends, friendsCount: activeFriends.count)
    }
}
