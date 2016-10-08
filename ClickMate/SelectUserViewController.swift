//
//  SelectUserViewController.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/6/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print("SnapShot: \(snapshot)")
            
            let user = User()
            var tempDict = ["":""]
            tempDict = snapshot.value as! Dictionary
            if tempDict["email"] != nil {
                print("Found email: ")
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
        
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel!.text = user.email
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let click = ["from":user.email,"description":descrip,"imageURL":imageURL]
        
        FIRDatabase.database().reference().child("clicks").child(user.uid).child("click").childByAutoId().setValue(click)
        
        navigationController!.popToRootViewController(animated: true)
        
    }
}
