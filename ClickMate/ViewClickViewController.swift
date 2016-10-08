//
//  ViewClickViewController.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/7/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit

class ViewClickViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UILabel!
    
    var click = Click()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descriptionTextField.text = click.descrip
        
        
    }

}
