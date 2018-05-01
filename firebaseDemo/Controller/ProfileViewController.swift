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

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView:UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "PersonTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "PersonCell")
        tableView.backgroundColor = UIColor(white: 0.50,alpha:1.0)
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        } else {
            // Fallback on earlier versions
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        observePosts()
        
    }
    
    func observePosts() {
        let postsRef = Database.database().reference().child("posts")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Post]()
            
            
            for child in snapshot.children {
                let currentID: String = (Auth.auth().currentUser?.uid)!
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                    let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                    let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)

                    if uid == currentID{
                        tempPosts.append(post)
                    }

                }
                
            }
            
            self.posts = tempPosts
            self.tableView.reloadData()
            
        })
    }
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
}
