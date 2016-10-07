//
//  PictureViewController.swift
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

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        nextButton.isEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func nextTapped(_ sender: AnyObject) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.10)
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData!, metadata: nil, completion: {(metadata, error) in
            
            print("We are trying to load the image now")
            if error != nil {
                print("We had an error: \(error)")
            } else {
                print(metadata?.downloadURL())
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        
    }
}
