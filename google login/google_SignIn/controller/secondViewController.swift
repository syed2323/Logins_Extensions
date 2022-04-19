//
//  secondViewController.swift
//  google login
//
//  Created by MAC on 24/11/20.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit


class secondViewController: UIViewController {
    
    
    var l11 : String!
    var l22 : String!
    var l33 : URL!
    
    let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ll1: UILabel!
    @IBOutlet weak var ll2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ll1.text = l11
        ll2.text = l22
        
        img.layer.cornerRadius = 50
        img.layer.borderWidth = 2.0
        img.clipsToBounds = true
        
        let url = l33
           // Fetch Image Data
        if let data = try? Data(contentsOf: url!) {
               // Create Image and Update Image View
            img.image = UIImage(data: data)
           }
        
        firebaseAuth.addStateDidChangeListener { auth, user in
            if let user = user {
                print("User is signed in.")
            } else {
                print("User is signed out.")
                AccessToken.current = nil
                self.performSegue(withIdentifier: "ViewController", sender: nil)
                self.dismiss(animated: true , completion: nil)
            }
        }
        
        
    }
    //MARK: - Google SignOut Button
    
    @IBAction func btn(_ sender: UIButton) {
       
    do {
        try
        firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
        
    }
    

}
