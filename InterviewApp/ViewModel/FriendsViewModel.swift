//
//  FriendsViewModel.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Combine
import UIKit

@MainActor
class FriendsViewModel {
    @Published private(set) var user: User?
    @Published private(set) var friends: [Friend] = []
    @Published private(set) var loadingStatus: LoadingStatus = .notLoaded

    var scenario: DataService.Scenario = .scenario1 {
        didSet {
            clearCache()
        }
    }

//    private let dataManager = DataService(api: FriendsMockApi(delay: .seconds(0)))
    private let dataManager = DataService(api: FriendsApi())
    private var subscriptions = Set<AnyCancellable>()

    init() {
        subscribeNotifications()
    }

    func loadData(reload: Bool = false, completion: (() -> Void)? = nil) {
        guard loadingStatus == .notLoaded || reload else {
            completion?()
            return
        }
        loadingStatus = .loading
        Task {
            do {
                async let asyncUser = dataManager.loadUser()
                async let asyncFriends = dataManager.loadFriends(scenario)
                let (user, friends) = (try await asyncUser, try await asyncFriends)
                await MainActor.run {
                    self.user = user
                    self.friends = friends
                    self.loadingStatus = .loaded
                    completion?()
                }
            } catch {
                await MainActor.run {
                    Alert.show(
                        title: "Error",
                        message: error.localizedDescription
                    )
                    completion?()
                }
            }
        }
    }

    // FE only simulated behavior
    func acceptInvitation(_ friend: Friend) {
        guard let index = friends.firstIndex(where: { $0.fid == friend.fid }) else { return }
        friends[index] = friends[index].copyWithNewStatus(.invited)
    }

    // FE only simulated behavior
    func declineInvitation(_ friend: Friend) {
        guard let index = friends.firstIndex(where: { $0.fid == friend.fid }) else { return }
        friends[index] = friends[index].copyAsDeclined()
    }

    private func clearCache() {
        user = nil
        friends = []
        loadingStatus = .notLoaded
    }
}

// MARK: - LoadingStatus

extension FriendsViewModel {
    enum LoadingStatus {
        case notLoaded
        case loading
        case loaded
    }
}

// MARK: - Testing (For changing scenarios)

private extension FriendsViewModel {
    func subscribeNotifications() {
        NotificationCenter.default.publisher(for: .changeScenario)
            .sink { [weak self] in
                if let self,
                   let userInfo = $0.userInfo,
                   let scenario = NotificationUserInfo.getScenario(from: userInfo) {
                    Logger.debug("FriendsViewModel - changing scenario to \(scenario)")
                    self.scenario = scenario
                }
            }
            .store(in: &subscriptions)
    }
}

extension NSNotification.Name {
    static let changeScenario = NSNotification.Name(rawValue: "changeScenario")
}

enum NotificationUserInfo {
    static let scenario = "scenario"
}

extension NotificationUserInfo {
    static func create(scenario: DataService.Scenario) -> [AnyHashable: Any] {
        [NotificationUserInfo.scenario: scenario]
    }

    static func getScenario(from userInfo: [AnyHashable: Any]) -> DataService.Scenario? {
        userInfo[NotificationUserInfo.scenario] as? DataService.Scenario
    }
}
