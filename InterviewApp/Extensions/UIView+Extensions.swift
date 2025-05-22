//
//  UIView+Extensions.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import UIKit

public extension UIView {
    // From https://stackoverflow.com/a/26018312
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll()
        return contentView
    }
}

public extension UIView {
    /// attaches all sides of the receiver to its parent view
    func layoutAttachAll(margin : CGFloat = 0.0) {
        let view = superview
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)
    }

    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    @discardableResult
    func layoutCenterHorizontally(to: UIView? = nil) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        superview?.addConstraint(constraint)
        return constraint
    }

    @discardableResult
    func layoutCenterVertically(to: UIView? = nil) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        superview?.addConstraint(constraint)
        return constraint
    }

    @discardableResult
    func layoutFixedWidth(_ width: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        if let priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    @discardableResult
    func layoutFixedHeight(_ height: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        if let priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    func layoutFixedSize(_ size: CGSize) {
        layoutFixedWidth(size.width)
        layoutFixedHeight(size.height)
    }
}
