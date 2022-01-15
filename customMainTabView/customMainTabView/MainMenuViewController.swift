//
//  MainMenuViewController.swift
//  customMainTabView
//
//  Created by pbk on 2021/12/29.
//

import UIKit

class MainMenuViewController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
//        tabBar.itemWidth = 1
//        tabBar.itemPositioning = .centered
        print(#function)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        
    }
    
    private func setup() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        moreNavigationController.delegate = self
    }
    


}

extension MainMenuViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        navigationController.viewControllers.removeFirst()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

//        if (navigationController.viewControllers.first?.title?.contains("More")) == true {
//            navigationController.viewControllers.removeFirst()
//        }
//        let item = viewController.navigationItem
//        navigationController.isNavigationBarHidden = !(item.title?.isEmpty == false || item.titleView != nil)
    }
    
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}




