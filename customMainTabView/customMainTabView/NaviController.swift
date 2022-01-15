//
//  NaviController.swift
//  customMainTabView
//
//  Created by pbk on 2021/12/29.
//

import UIKit

class NaviController: UINavigationController {

    var index:Int = 0 {
        didSet {
            guard let vc = viewControllers.compactMap({ $0 as? LabelTestViewController }).first else { return }
            vc.index = self.index
        }
    }

    
    override func loadView() {
        super.loadView()
        print("\(#function) \(tabBarItem?.title ?? "")")
    }

    
    class var custom:NaviController {
        let name = randomString(of: 5)
        let vc = LabelTestViewController()
        vc.navigationItem.title = name
        let navi = NaviController()
        navi.navigationBar.tintColor = .random
        navi.tabBarItem.title = name
        navi.viewControllers = [vc]
        return navi
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print(self.viewIfLoaded?.isHidden)
//    }
//    
//    override func willMove(toParent parent: UIViewController?) {
//        super.willMove(toParent: parent)
//        print("\(type(of: self)) \(#function) \(tabBarItem.title ?? "")")
//        guard isViewLoaded else { return }
//        print(view.superview)
//
//    }
//    
//    override func didMove(toParent parent: UIViewController?) {
//        super.didMove(toParent: parent)
//        print("\(type(of: self)) \(#function) \(tabBarItem.title ?? "")")
//        guard isViewLoaded else { return }
//        print(view.superview)
//    }
}
func randomString(of length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var s = ""
    for _ in 0 ..< length {
        s.append(letters.randomElement()!)
    }
    return s
}
extension UIColor {
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
