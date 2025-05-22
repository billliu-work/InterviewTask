//
//  CollapsibleContainerView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

public class CollapsibleContainerView: UIView {
    public var paddings: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)

    public var spacing: CGFloat = 10
    public var collapsedOffset: CGFloat = 10
    public var collapsedScale: CGFloat = 0.9

    public private(set) var isCollapsed = false
    public private(set) var collapsibleViews: [UIView] = []

    private var heightConstraint: NSLayoutConstraint?

    public override init(frame: CGRect) {
        Logger.debug("CollapsibleContainerView - init:frame")
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        Logger.debug("CollapsibleContainerView - init:coder")
        super.init(coder: aDecoder)
        commonInit()
    }

    public func addCollapsibleView(_ view: UIView, animated: Bool = true, layout: Bool = true) {
        dropShadow(view)
        collapsibleViews.append(view)
        self.insertSubview(view, at: 0)
        if layout {
            updateLayout(animated: animated)
        }
    }

    public func removeCollapsibleView(_ view: UIView, animated: Bool = true, layout: Bool = true) {
        view.removeFromSuperview()
        collapsibleViews.removeAll {
            $0 == view
        }
        if layout {
            updateLayout(animated: animated)
        }
    }

    public func updateLayout(animated: Bool = true) {
        if animated {
            updateViewHeight()
            UIView.animate(withDuration: 0.3) {
                self.updateCollapsibleViews()
                self.superview?.layoutIfNeeded()
            } completion: { _ in
                self.collapsibleViews.forEach {
                    $0.isHidden = $0.alpha == 0
                }
            }
        } else {
            updateCollapsibleViews()
            updateViewHeight()
        }
    }

    private func commonInit() {
        Logger.debug("CollapsibleContainerView - commonInit")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func onTapped(_ gesture: UITapGestureRecognizer) {
        Logger.debug("CollapsibleContainerView - onTapped")

        isCollapsed = !isCollapsed
        updateLayout()
    }

    private func updateCollapsibleViews() {
        guard !collapsibleViews.isEmpty else { return }

        var y: CGFloat = paddings.top
        let contentWidth = self.bounds.size.width - paddings.left - paddings.right

        func setViewFrame(_ view: UIView) {
            let x = (contentWidth - view.frame.size.width) / 2
            view.frame = CGRect(origin: .init(x: x, y: y), size: view.frame.size)
            view.transform = .identity
            view.isHidden = false
            view.alpha = 1
        }

        if isCollapsed {
            for i in 0..<collapsibleViews.count {
                let view = collapsibleViews[i]
                if i == 0 {
                    setViewFrame(view)
                } else {
                    y += collapsedOffset
                    setViewFrame(view)
                    view.transform = .init(scaleX: collapsedScale, y: collapsedScale)
                    if i > 1 {
                        view.alpha = 0
                    }
                }
            }
        } else {
            collapsibleViews.forEach { view in
                setViewFrame(view)
                y = view.frame.maxY + spacing
            }
        }
    }

    private func updateViewHeight() {
        var height: CGFloat = paddings.top + paddings.bottom
        if isCollapsed {
            height += (collapsibleViews.first?.bounds.size.height ?? 0)
            if collapsibleViews.count > 1 {
                height += collapsedOffset
            }
        } else {
            for i in 0..<collapsibleViews.count {
                if i > 0 {
                    height += spacing
                }
                height += collapsibleViews[i].bounds.size.height
            }
        }

        if let heightConstraint {
            heightConstraint.constant = height
        } else {
            heightConstraint = self.layoutFixedHeight(height, priority: .init(rawValue: 1000))
        }
    }

    private func dropShadow(_ view: UIView) {
        view.layer.shadowColor = UIColor(named: "colorLightGray2")?.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .init(width: 4, height: 4)
    }
}
