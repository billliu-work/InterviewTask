//
//  TabBarViewController.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/19.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let bar = tabBar as? LargeMiddleButtonTabBar {
            bar.onMiddleButtonClicked = { [weak self] in
                self?.selectedIndex = $0
            }
        }
    }
}
