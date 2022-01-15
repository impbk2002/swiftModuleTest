//
//  SceneDelegate.swift
//  customMainTabView
//
//  Created by iquest1127 on 2021/12/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    static var instance:Self? {
        UIApplication.shared.connectedScenes
            .compactMap{ $0 as? UIWindowScene }
            .compactMap{ $0.delegate as? Self }
            .first
    }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene), session.role == .windowApplication else { return }
        let newKey = UIWindow(windowScene: windowScene)
        newKey.makeKeyAndVisible()
        window = newKey
        let sample = TestCase.Four
        switch sample {
        case .One:
            let tabVC = MainMenuViewController()
            tabVC.delegate = self
            let vcList:[NaviController] = ((0..<8)).map{
                
                let vc = NaviController.custom
                vc.index = $0
                return vc
            }
            
            tabVC.viewControllers = vcList
            tabVC.tabBar.itemWidth = 20
            let holder = UINavigationController(rootViewController: tabVC)
            holder.setOverrideTraitCollection(.init(traitsFrom: [.init(horizontalSizeClass: .regular), .init(userInterfaceIdiom: .tv)]), forChild: tabVC)
            newKey.rootViewController = holder
        case .Two:
            let tabVC = MainMenuViewController()
            tabVC.delegate = self
            let vcList:[NaviController] = ((0..<8)).map{
                
                let vc = NaviController.custom
                vc.index = $0
                return vc
            }
            
            tabVC.viewControllers = vcList
            tabVC.tabBar.itemWidth = 20
//            let holder = UINavigationController(rootViewController: tabVC)
            let holder = UIViewController()
            holder.addChild(tabVC)
            holder.view.addSubview(tabVC.view)
            tabVC.didMove(toParent: holder)
            holder.setOverrideTraitCollection(.init(traitsFrom: [.init(horizontalSizeClass: .regular), .init(userInterfaceIdiom: .tv)]), forChild: tabVC)
            newKey.rootViewController = holder
        case .Three:
            let menu = Test2ViewController()
            newKey.rootViewController = menu
        case .Four:
            let holder = UIViewController()
            let menu = UIStoryboard(name: "MenuStoryboard", bundle: nil).instantiateInitialViewController()!
            
            holder.addChild(menu)
            holder.view.addSubview(menu.view)
            menu.didMove(toParent: holder)
            holder.setOverrideTraitCollection(.init(traitsFrom: [.init(horizontalSizeClass: .regular), .init(userInterfaceIdiom: .tv)]), forChild: menu)
            newKey.rootViewController = holder
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(#function)
    }
}



enum TestCase {
    case One
    case Two
    case Three
    case Four
}
