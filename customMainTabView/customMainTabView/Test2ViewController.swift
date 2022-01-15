//
//  Test2ViewController.swift
//  customMainTabView
//
//  Created by iquest1127 on 2022/01/05.
//

import UIKit

class Test2ViewController: UIViewController {

    let manyVC:[UIViewController] = {
        (0...10).map{
            let tabChilds = (0...3).map{ idx -> UIViewController in
                let vc = NaviController.custom
                vc.index = idx
                return vc
            }
            let test = UIViewController()
            test.title = "test"
            let tabVC = UITabBarController()
            tabVC.title = "\($0)"
            tabVC.viewControllers = tabChilds + [test]
            return tabVC
        }
    }()
    let splitVC : UISplitViewController = {
        let vc = UISplitViewController()
        vc.preferredDisplayMode = .secondaryOnly
        vc.maximumPrimaryColumnWidth = 275

        return vc
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        splitVC.delegate = self
        addChild(splitVC)
        splitVC.didMove(toParent: self)
        setOverrideTraitCollection(.init(horizontalSizeClass: .regular), forChild: splitVC)
        let menu = SideViewController()
        menu.title = ""
        menu.SideDelegate = self
        splitVC.viewControllers = [menu]

    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(splitVC.view)
        splitVC.showDetailViewController(manyVC.first!, sender: nil)
        
    }


    
    func selectIndex(n:Int) {
        guard manyVC.indices.contains(n) else {return}
//        splitVC.setViewController(manyVC[n], for: .secondary)
        let child = manyVC[n]
        splitVC.showDetailViewController(child, sender: self)
        if splitVC.preferredDisplayMode != .oneOverSecondary {
            splitVC.preferredDisplayMode = .oneOverSecondary
        }
    }

}

extension Test2ViewController: UISplitViewControllerDelegate {


    
    func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewController.DisplayMode {
        guard svc.preferredDisplayMode != .oneOverSecondary else { return .automatic }
        guard svc.displayMode != .oneOverSecondary else {
            svc.preferredDisplayMode = .oneOverSecondary
            return .automatic
        }

        return .oneOverSecondary
    }
}

extension UISplitViewController {
    var customDisplayButton:UIBarButtonItem {
        let origin = displayModeButtonItem
        let custom = UIBarButtonItem(image: .init(systemName: "folder"), style: .plain, target: origin.target, action: origin.action)
        return custom
    }
    
    func toggleDisplayMode() {
        let button = displayModeButtonItem
        guard let _action = button.action else { return }
        let flag = UIApplication.shared.sendAction(_action, to: button.target, from: nil, for: nil)
        print("\(#function) \(flag)")
    }
}

extension Test2ViewController: SideButtonDelegate {
    func tapped(n: Int) {
        selectIndex(n: n)
        splitVC.toggleDisplayMode()
    }
}
