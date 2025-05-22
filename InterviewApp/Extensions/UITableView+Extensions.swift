//
//  UITableView+Extensions.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

public extension UITableView {
    // Convenience method which assumes nib name is the same as reuse identifier
    func registerCell(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
