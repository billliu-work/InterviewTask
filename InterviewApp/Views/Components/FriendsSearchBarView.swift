//
//  FriendsSearchBarView.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/22.
//

import UIKit

enum SearchState {
    case none
    case searching(String)
}

class FriendsSearchBarView: XibView {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addFriendButton: UIButton!

    var onSearchStateChange: ((SearchState) -> Void)?
    var onAddFriend: (() -> Void)?

    override func commonInit() {
        if let color = UIColor(named: "colorSteel") {
            textField.attributedPlaceholder = NSAttributedString(
                string: "想轉一筆給誰呢?",
                attributes: [NSAttributedString.Key.foregroundColor: color]
            )
        }

        if let image = UIImage(named: "icSearchBarSearchGray") {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(
                origin: .init(x: 10, y: 0),
                size: .init(width: 14, height: 14)
            )
            imageView.contentMode = .scaleAspectFit
            let paddedView = UIView(frame: CGRect(origin: .zero, size: .init(width: 24, height: 14)))
            paddedView.addSubview(imageView)
            textField.leftView = paddedView
            textField.leftViewMode = .always
            textField.delegate = self
        }
    }

    @IBAction func onAddFriendClicked(_ sender: UIButton) {
        Logger.info("FriendsSearchBarView - onAddFriendClicked")
        onAddFriend?()
    }

    private func notifyState(isEditing: Bool, text: String?) {
        guard let onSearchStateChange else { return }
        let text = text ?? ""
        if !isEditing, text.isEmpty {
            onSearchStateChange(.none)
        } else {
            onSearchStateChange(.searching(text))
        }
    }
}

extension FriendsSearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Logger.info("FriendsSearchBarView - textFieldDidEndEditing")
        notifyState(isEditing: true, text: textField.text)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        Logger.info("FriendsSearchBarView - textFieldDidEndEditing")
        notifyState(isEditing: false, text: textField.text)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        Logger.info("FriendsSearchBarView - textFieldDidEndEditing:reason")
        notifyState(isEditing: false, text: textField.text)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Logger.info("FriendsSearchBarView - shouldChangeCharactersIn")
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            notifyState(isEditing: true, text: newText)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Logger.info("FriendsSearchBarView - textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
}

