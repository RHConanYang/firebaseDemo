//
//  FoundUserViewController.swift
//  firebaseDemo
//
//  Created by 楊仁翰 on 2018/5/6.
//  Copyright © 2018年 Renhen Yang. All rights reserved.
//

import UIKit
import Firebase

class FoundUserViewController: UIViewController, UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate {

    let searchController = UISearchBar()
    var users = [UserProfile]()
    var filteredUsers = [UserProfile]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        

        definesPresentationContext = true
        configureSearchBar()

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configureSearchBar() {
        navigationItem.titleView = searchController

        searchController.sizeToFit()
        searchController.placeholder = ""
        searchController.delegate = self

        definesPresentationContext = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let postsRef = Database.database().reference().child("users/profile")
        
        guard !searchText.isEmpty else {
            return
        }
        postsRef.queryOrdered(byChild: "username").queryStarting(atValue: searchText).queryEnding(atValue: searchText+"\u{f8ff}").observe(.value) { (snapshot) in
            
            var temp = [UserProfile]()
            for child in snapshot.children.allObjects {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:AnyObject],
                    let uid = snapshot.key as String?,
                    let username = dict["username"] as! String?,
                    let photoURL = dict["photoURL"] as! String?,
                    let url = URL(string:photoURL){
                    
                    let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                    temp.append(userProfile)
                }
            }
            self.users = temp
            self.tableView.reloadData()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.showsCancelButton = true
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.showsCancelButton = false
        searchController.text = ""
        searchController.resignFirstResponder()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.resignFirstResponder()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.textLabel?.text = users[indexPath.row].username
        cell.detailTextLabel?.text = users[indexPath.row].uid

        return cell
    }

}
