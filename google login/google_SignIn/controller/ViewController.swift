//
//  ViewController.swift
//  google login
//
//  Created by MAC on 23/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseUI
import AuthenticationServices
import FBSDKLoginKit

class ViewController: UIViewController,GIDSignInDelegate, FUIAuthDelegate, LoginButtonDelegate {
   
    
var name = ""
var email = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        Facebook_login.delegate = self
        Facebook_login.permissions = ["email"]
       
    }

    // MARK: - Google SignIn Process

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      
      if let error = error {
        print("\(error.localizedDescription)")
        return
      }
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase Sign in error")
                print(error)
            }else {
                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      let detail:secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
                
                if let name = authResult?.user.displayName{
                    detail.l11 = name
                }
                if let profile = authResult?.additionalUserInfo{
                    debugPrint(profile)
                }
                if let email = authResult?.user.email{
                    detail.l22 = email
                }
                if let photo = authResult?.user.photoURL{
                    print(photo)
                    detail.l33 = photo
                }
                print("user is sign in with Firebase")
                self.navigationController?.pushViewController(detail, animated: true)
            }

        }
    }
    // MARK: - signin button
    @IBOutlet weak var signInButton: GIDSignInButton!

    
    // MARK: - apple login
       @IBAction func login(_ sender: Any) {
           AppleLoginHelper.shared.loginProcess()
         
       }
    // MARK: - Facebook Login
    
    @IBOutlet weak var Facebook_login: FBLoginButton!
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
          print("\(error.localizedDescription)")
          return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken:
                                                                AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
                if  let error = error {
                    print("Not to login in firebase")
                    print(error)
                }
                else{
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let detail:secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
                    
                    if let fbname = authResult?.user.displayName{
                        detail.l11 = fbname
                    }
                    if let fbprofile = authResult?.additionalUserInfo{
                        debugPrint(fbprofile)
                    }
                    if let fbemail = authResult?.user.email{
                        detail.l22 = fbemail
                    }
                    if let photo = authResult?.user.photoURL{
                        print(photo)
                        detail.l33 = photo
                    }
                    debugPrint("sssssssssssssssss.................................")
                    
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user logout")
    }
    
    
    
    
    
    
}
