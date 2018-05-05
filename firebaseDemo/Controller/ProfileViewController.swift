//
//  ProfileViewController.swift
//  firebaseDemo
//
//  Created by 楊仁翰 on 2018/5/1.
//  Copyright © 2018年 Renhen Yang. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController {
    var tableView:UITableView!
    
    var posts = [Post]()

    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var postsView: UIView!
    @IBOutlet weak var followerView: UIView!
    @IBOutlet weak var imageHead: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageHead.layer.cornerRadius = 10
        imageHead.clipsToBounds = true
        
        let profile = UserService.currentUserProfile
        ImageService.getImage(withURL: (profile?.photoURL)!) { image in
            self.imageHead.image = image
        }
        userName.text = profile?.username

        
    }
    

    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
    }
    

    @IBAction func showComponents(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5) {
                self.postsView.alpha = 1
                self.followerView.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.postsView.alpha = 0
                self.followerView.alpha = 1
            }
        }
    }
}
