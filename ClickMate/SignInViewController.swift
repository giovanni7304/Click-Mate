//
//  SignInViewController.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/3/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("ViewController Loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func trymeTapped(_ sender: AnyObject) {
        
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("we tried to sign in")
            if error != nil {
                print("hey we have an error: \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create user")
                    if error != nil {
                        print("Hey we have and error:\(error)")
                    } else {
                        print("Signed in Successfully")
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user?.email)

                        
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
            } else {
                print("hey we have signed in success")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
        
    }

}

