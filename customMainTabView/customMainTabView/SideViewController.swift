//
//  SideViewController.swift
//  customMainTabView
//
//  Created by iquest1127 on 2022/01/05.
//

import UIKit

class SideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    weak var SideDelegate:SideButtonDelegate?
    
    @IBAction func action1(_ sender: Any) {
        SideDelegate?.tapped(n: 1)
    }
    
    @IBAction func action2(_ sender: Any) {
        SideDelegate?.tapped(n: 2)
    }
    
    @IBAction func action3(_ sender: Any) {
        SideDelegate?.tapped(n: 3)
    }
    
}

protocol SideButtonDelegate: AnyObject {
    func tapped(n:Int)
}
