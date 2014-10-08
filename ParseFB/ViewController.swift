//
//  ViewController.swift
//  ParseFB
//
//  Created by Evan Gapella on 8/10/2014.
//  Copyright (c) 2014 Evan Gapella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //LOGIN WITH FB
    @IBAction func loginButton(sender: AnyObject) {
        var permissions = ["public_profile", "email", "user_likes", "user_friends"]
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
            } else {
                var user = PFUser.currentUser()
                var userEmailString = user.email
                println(userEmailString)
                self.nameLabel.text = userEmailString
                NSLog("User logged in through Facebook!")
            }
        })
}

    //DELETE ACCOUNT FROM FB
    @IBAction func deleteAccountButton(sender: AnyObject) {
        var user = PFUser.currentUser()
        
        PFFacebookUtils.unlinkUserInBackground(user, {
            (succeeded: Bool!, error: NSError!) -> Void in
            if (succeeded != nil) {
                NSLog("The user is no longer associated with their Facebook account.")
            }
        })
    }
}

