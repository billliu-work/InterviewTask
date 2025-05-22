//
//  UIStoryboard+Extensions.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/21.
//

import UIKit

public extension UIStoryboard {
    static func viewController(_ identifier: String, bundleName: String = "Main") -> UIViewController? {
        UIStoryboard(name: bundleName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
