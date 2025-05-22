//
//  LargeMiddleButtonTabBar.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/19.
//

import UIKit

/// For handling tabbars with large middle button, so will check for negative top image inset
public class LargeMiddleButtonTabBar: UITabBar {
    public var onMiddleButtonClicked: ((Int) -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        guard let image = UIImage(named: "imgTabbarBg") else { return }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
        imageView.layoutAttachLeading()
        imageView.layoutAttachTrailing()
        imageView.layoutAttachTop(margin: -15)
        imageView.layoutFixedHeight(68)
    }

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        func getClickedMiddleItemIndex() -> Int? {
            guard let items, items.count > 0 else { return nil }
            let middleIndex = items.count/2
            let middleButton = items[middleIndex]
            let middleWidth = bounds.width/CGFloat(items.count)
            guard let image = middleButton.image, middleButton.imageInsets.top < 0 else { return nil }
            let rect = CGRect(
                x: (bounds.size.width - middleWidth) / 2,
                y: middleButton.imageInsets.top,
                width: image.size.width,
                height: image.size.height - middleButton.imageInsets.top
            )
            if rect.contains(point) {
                return middleIndex
            }
            return nil
        }
        if let index = getClickedMiddleItemIndex() {
            onMiddleButtonClicked?(index)
            return nil
        }
        return super.hitTest(point, with: event)
    }
}
