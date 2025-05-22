//
//  UIView+Visibility.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

// Some convenience function for toggling visibilities
extension UIView {
    static func show(views: [UIView], isShowing: Bool, animated: Bool = true, duration: TimeInterval = 0.3) {
        func perform() {
            views.forEach {
                $0.isHidden = !isShowing
                $0.alpha = isShowing ? 1 : 0
            }
        }
        if animated {
            UIView.animate(withDuration: duration) {
                perform()
            } completion: { _ in
                // This is needed for UIStackView bug
                views.forEach {
                    $0.isHidden = !isShowing
                }
            }
        } else {
            perform()
        }
    }
}
