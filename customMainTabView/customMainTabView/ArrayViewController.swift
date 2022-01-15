//
//  ArrayViewController.swift
//  customMainTabView
//
//  Created by iquest1127 on 2022/01/04.
//

import UIKit

class ArrayViewController: UIViewController {

    var childList:[UIViewController] = [] {
        willSet {
            unregisterChilds()
        }
        didSet {
            registerChilds()
        }
    }

    private(set) var currentIndex = 0

    private func registerChilds() {
        childList.forEach(self.addChild)
        childList.forEach{ $0.didMove(toParent: self) }
        if isViewLoaded {
            addInitialView()
        }
        print(#function)
    }

    private func unregisterChilds() {
        childList.forEach{
            $0.willMove(toParent: nil)
            $0.viewIfLoaded?.removeFromSuperview()
            $0.removeFromParent()
        }
        print(#function)
    }
    
    func selectIndex(n:Int) {
        guard childList.indices.contains(n) else { return }
        guard childList.indices.contains(currentIndex) else { return }
        print("from \(currentIndex) to \(n)")
        transition(from: childList[currentIndex], to: childList[n], duration: 0, options: [], animations: {}) { _ in
            self.currentIndex = n
        }
        
    }
    
    override func loadView() {
        super.loadView()
        addInitialView()
    }
    

    private func addInitialView() {
        guard let vc = childList.first else { return }
        self.view.addSubview(vc.view)
        currentIndex = 0
    }
    
}
