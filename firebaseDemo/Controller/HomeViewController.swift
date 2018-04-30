//
//  HomeViewController.swift
//  firebaseDemo
//
//  Created by 楊仁翰 on 2018/4/29.
//  Copyright © 2018年 Renhen Yang. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLogout(_ target: UIBarButtonItem) {
        try! Auth.auth().signOut()

    }

    

}
