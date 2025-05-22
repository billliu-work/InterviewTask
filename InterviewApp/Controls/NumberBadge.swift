//
//  NumberBadge.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

class NumberBadge: UIView {
    @IBInspectable var value: Int = 0 {
        didSet {
            Logger.debug("NumberBadge didSet value [\(value)]")
            if value <= 0 {
                self.isHidden = true
            } else {
                self.isHidden = false
                numberLabel.text = value > 99 ? "99+" : String(value)
                setNeedsLayout()
            }
        }
    }

    @IBInspectable var textColor: UIColor? = UIColor(named: "colorWhiteThree") {
        didSet {
            numberLabel.textColor = textColor
        }
    }

    @IBInspectable var font: UIFont? = UIFont(name: "PingFangTC-Medium", size: 12) {
        didSet {
            numberLabel.font = font
            setNeedsLayout()
        }
    }

    private let horizontalPadding: CGFloat = 4
    private let verticalPadding: CGFloat = 2
    private var numberLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let labelSize = numberLabel.sizeThatFits(CGSize(width: 1000, height: 50))
        var viewSize = CGSize(width: labelSize.width + horizontalPadding * 2, height: labelSize.height + verticalPadding * 2)
        // Make square if too thin
        viewSize.width = max(viewSize.width, viewSize.height)

        numberLabel.frame = CGRect(
            origin: .init(
                x: (viewSize.width - labelSize.width) / 2,
                y: (viewSize.height - labelSize.height) / 2
            ),
            size: labelSize
        )
        self.frame = CGRect(origin: self.frame.origin, size: viewSize)
        self.layer.cornerRadius = viewSize.height / 2
    }

    private func commonInit() {
        let label = UILabel(frame: .zero)
        label.text = String(value)
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        self.addSubview(label)
        self.numberLabel = label

        self.backgroundColor = UIColor(named: "colorVeryLightPink")
        self.clipsToBounds = false
    }
}
