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
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.blue
        view.addSubview(tableView)
        
        
        var layoutGuide:UILayoutGuide
        if #available(iOS 11.0, *){
            layoutGuide = view.safeAreaLayoutGuide
        }else {
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        
        
    }
    
    @IBAction func handleLogout(_ target: UIBarButtonItem) {
        try! Auth.auth().signOut()

    }

    

}
