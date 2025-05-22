//
//  ChatView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class ChatView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let label = UILabel(frame: bounds)
        label.text = "Chat (WIP)"
        label.textColor = .black
        label.textAlignment = .center
        self.addSubview(label)
    }
}
