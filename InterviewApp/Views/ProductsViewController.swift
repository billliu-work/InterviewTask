//
//  ProductsViewController.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/21.
//

import UIKit

@MainActor
class ProductsViewController: UIViewController {
//    @IBOutlet weak var stackview: UIStackView!
//    @IBOutlet weak var button1: UIButton!
//    @IBOutlet weak var button2: UIButton!

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let colors: [UIColor] = [
//            .red,
//            .yellow,
//            .green,
//            .blue,
//            .cyan,
//        ]
//
//        let rect = CGRect(x: 0, y: 0, width: 100, height: 70)
//        colors.forEach {
//            let view = UILabel(frame: rect)
//            view.backgroundColor = $0
//            container1View.addCollapsibleView(view)
//        }
//    }

    // For testing only
    @IBAction func onSetScenario(_ sender: UIButton) {
        guard let scenario = DataService.Scenario(rawValue: sender.tag) else { return }
        Logger.debug("ProductsViewController - onSetScenario - tag: \(sender.tag), scenario: \(scenario)")
        NotificationCenter.default.post(name: .changeScenario, object: nil, userInfo: NotificationUserInfo.create(scenario: scenario))
        Alert.show(
            message: "Selected \(scenario)"
        )
    }
}
