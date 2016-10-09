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
    
    var clicks : [Click] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        // Do any additional setup after loading the view.
        FIRDatabase.database().reference().child("clicks").child(FIRAuth.auth()!.currentUser!.uid).child("click").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            //print("SnapShot: \(snapshot)")
            
            let click = Click()
            var tempDict = ["":""]
            tempDict = snapshot.value as! Dictionary
            if tempDict["from"] != nil {
                //print("found: the from \(tempDict)")
                click.from = tempDict["from"]!
                click.key  = snapshot.key
                click.descrip = tempDict["description"]!
                click.imageURL = tempDict["imageURL"]!
                click.uuid = tempDict["uuid"]!
            } else {
                click.from = "ERROR"
                click.key = "ERROR"
                click.descrip = "ERROR"
                click.imageURL = "ERROR"
                click.uuid = "ERROR"
            }
            
            //print("click: ",tempDict["from"]!)
            self.clicks.append(click)
            self.tableView.reloadData()
        
        })
        
        FIRDatabase.database().reference().child("clicks").child(FIRAuth.auth()!.currentUser!.uid).child("click").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            //print("SnapShot: \(snapshot)")
            
           var index = 0
            for click in self.clicks {
                if click.key == snapshot.key {
                    self.clicks.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if clicks.count == 0 {
            return 1
        } else {
            return clicks.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let click = clicks[indexPath.row]
        
        performSegue(withIdentifier: "viewClicksegue", sender: click)
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if clicks.count == 0 {
            cell.textLabel!.text = "You have no Clicks 😞"
        } else {
        
            let click = clicks[indexPath.row]
            cell.textLabel!.text = click.from
        }
        //print("tableview: \(click.from)")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewClicksegue" {
            
            let nextVC = segue.destination as! ViewClickViewController

            nextVC.click = sender as! Click
        }
    
    }
    
    @IBAction func logOutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
