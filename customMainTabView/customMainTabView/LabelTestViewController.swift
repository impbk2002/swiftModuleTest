//
//  LabelTestViewController.swift
//  customMainTabView
//
//  Created by iquest1127 on 2021/12/30.
//

import UIKit

class LabelTestViewController: UIViewController {
    var index:Int = 0
    var flag = true
    override func loadView() {
        let test = TestView()
        test.id = navigationItem.title ?? ""
        test.backgroundColor = .gray.withAlphaComponent(0.6)
        
        view = test
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if flag && navigationController is NaviController {
//            print(#function)
//            navigationController?.viewControllers = [self]
//            flag = false
//        }
//        navigationItem.rightBarButtonItem = .init(title: "\(index)", style: .plain, target: self, action: #selector(moveNext))
    }
    
    @objc func moveNext() {
        guard let main = SceneDelegate.instance?.window?.rootViewController as? ArrayViewController else {return}
        let target = (index + 1) >= main.childList.count ? 0 : (index + 1)
        print("\(main) is presenting \(main.presentedViewController)")
        print("which is presented by \(main.presentingViewController)")
        main.selectIndex(n: target)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.leftBarButtonItem = splitViewController?.customDisplayButton
        let selfType = type(of: self)
        let naiType = type(of: navigationController ?? NSNull())
        print("\(#function) \(selfType) \(naiType)")
//        let vc = UIViewController()
//        vc.modalPresentationStyle = .formSheet
//        present(vc, animated: true) {
//            let _vc = SceneDelegate.instance?.window?.rootViewController?.topMostViewController()
//            print(_vc)
//        }
    }

}




class TestView: UIView {
    var id:String = ""
//    override func removeFromSuperview() {
//        super.removeFromSuperview()
//        print("\(#function) \(id)")
//    }
//
//    override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//        print("\(#function) \(id)")
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        print("\(#function) \(id)")
//    }
//
//    override func willMove(toWindow newWindow: UIWindow?) {
//        super.willMove(toWindow: newWindow)
//        print("\(#function) \(id) \(newWindow)")
//    }
}
