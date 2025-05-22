//
//  GradientButton.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/21.
//

import UIKit

class GradientButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            gradientLayer?.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var startColor: UIColor = .white {
        didSet {
            updateGradientColors()
        }
    }

    @IBInspectable var endColor: UIColor = .white {
        didSet {
            updateGradientColors()
        }
    }

    @IBInspectable var trailingIcon: UIImage? {
        didSet {
            trailingIconView?.image = trailingIcon
        }
    }

    private var trailingIconView: UIImageView?
    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateButtonState(isPressed: true)
        return super.beginTracking(touch, with: event)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        func isHit() -> Bool {
            guard let superview else { return false }
            return frame.contains(touch.location(in: superview))
        }
        updateButtonState(isPressed: isHit())
        return super.beginTracking(touch, with: event)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        updateButtonState(isPressed: false)
        return super.endTracking(touch, with: event)
    }

    override func cancelTracking(with event: UIEvent?) {
        updateButtonState(isPressed: false)
        return super.cancelTracking(with: event)
    }

    private func commonInit() {
        // Icon
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .init(width: 24, height: 24)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        self.trailingIconView = imageView
        imageView.layoutFixedSize(.init(width: 24, height: 24))
        imageView.layoutAttachTrailing(margin: 10)
        imageView.layoutCenterVertically()

        // Background gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        updateGradientColors(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer

        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .init(width: 4, height: 4)
    }

    private func updateGradientColors(_ layer: CAGradientLayer? = nil) {
        guard let layer = layer ?? gradientLayer else { return }
        layer.colors = [startColor.cgColor, endColor.cgColor]
    }

    private func updateButtonState(isPressed: Bool) {
        let scale: CGFloat = isPressed ? 0.9 : 1
        UIView.animate(withDuration: 0.1) {
            self.transform = .init(scaleX: scale, y: scale)
        }
    }
}
