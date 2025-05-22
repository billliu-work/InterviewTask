//
//  UIViewController+Extensions.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import UIKit

public extension UIViewController {
    static var topViewController: UIViewController? {
        UIWindow.currentWindow?.topViewController
    }

    static func getTopViewController(_ viewController: UIViewController?) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return getTopViewController(navigationController.visibleViewController)
        }
        if let tabBarController = viewController as? UITabBarController {
            let moreNavigationController = tabBarController.moreNavigationController
            if let topViewController = moreNavigationController.topViewController,
               topViewController.view.window != nil {
                return getTopViewController(topViewController)
            } else if let selectedViewController = tabBarController.selectedViewController {
                return getTopViewController(selectedViewController)
            }
        }
        if let presentedViewController = viewController?.presentedViewController {
            return getTopViewController(presentedViewController)
        }
        return viewController
    }
}
