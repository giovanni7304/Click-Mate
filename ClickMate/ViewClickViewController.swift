//
//  ViewClickViewController.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/7/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ViewClickViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UILabel!
    
    var click = Click()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descriptionTextField.text = click.descrip
        
        imageView.sd_setImage(with: URL(string: click.imageURL))
    }

    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("clicks").child(FIRAuth.auth()!.currentUser!.uid).child("click").child(click.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(click.uuid).jpg").delete { (error) in
            print("Deleted")
        }
    }
}
