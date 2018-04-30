//
//  NewPostViewController.swift
//  firebaseDemo
//
//  Created by 楊仁翰 on 2018/4/30.
//  Copyright © 2018年 Renhen Yang. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class NewPostViewController:UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView:UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var cancelButton: UIBarButtonItem!


    

    @IBAction func handlePostButton() {
        
        let userProfile = UserService.currentUserProfile
        // Firebase code here
        print("11111111111\(String(describing: userProfile))")
        let postRef = Database.database().reference().child("posts").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile?.uid,
                "username": userProfile?.username,
                "photoURL": userProfile?.photoURL.absoluteString
            ],
            "text": textView.text,
            "timestamp": [".sv":"timestamp"]
            ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
                print("error")
            }
        })
    }
    
    @IBAction func handleCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        textView.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            super.dismiss(animated: flag, completion: completion)
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.tintColor = secondaryColor

        textView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
        
        // Remove the nav shadow underline
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
}
