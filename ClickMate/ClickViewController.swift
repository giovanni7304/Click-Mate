//
//  ClickViewController.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/5/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ClickViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print("SnapShot: \(snapshot)")
            
            let user = User()
            var tempDict = ["":""]
            tempDict = snapshot.value as! Dictionary
            if tempDict["email"] != nil {
                user.email = tempDict["email"]!
                user.uid = snapshot.key
            } else {
                user.email = "ERROR"
                user.uid = "ERROR"
            }
            
            self.users.append(user)
            self.tableView.reloadData()
            
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
    }
    
    @IBAction func logOutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
