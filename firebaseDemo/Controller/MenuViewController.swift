//
//  MenuViewController.swift
//  firebaseDemo
//
//  Created by 楊仁翰 on 2018/4/29.
//  Copyright © 2018年 Renhen Yang. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        // Add the background gradient
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        get {
//            return .lightContent
//        }
//    }
    
}
