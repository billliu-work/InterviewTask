//
//  Alert.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import UIKit

public enum Alert {
    public static func show(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = [],
        in viewController: UIViewController? = nil,
        animated: Bool = true
    ) {
        let viewController = viewController ?? UIViewController.topViewController
        guard let viewController else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach {
            alertController.addAction($0)
        }
        viewController.present(alertController, animated: animated)
    }

    public static func show(
        title: String? = nil,
        message: String? = nil,
        buttonText: String = "OK",
        onDismissed: (() -> Void)? = nil
    ) {
        show(
            title: title,
            message: message,
            actions: [
                .init(title: buttonText, style: .default) { _ in
                    onDismissed?()
                }
            ]
        )
    }
}

// MARK: - Convenience

public extension Alert {
    static func showWorkInProgressAlert() {
        show(
            title: "",
            message: "Work in progress...",
            actions: [
                .init(title: "OK", style: .default),
            ]
        )
    }
}
