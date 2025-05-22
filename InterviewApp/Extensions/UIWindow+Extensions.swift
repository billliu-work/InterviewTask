//
//  UIWindow+Extensions.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import UIKit

public extension UIWindow {
    static var currentWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap  { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }

    var topViewController: UIViewController? {
        UIViewController.getTopViewController(rootViewController)
    }
}
