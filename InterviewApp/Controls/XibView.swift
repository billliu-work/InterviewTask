//
//  XibView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import UIKit

open class XibView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        commonInit()
    }

    open func commonInit() {}
}
