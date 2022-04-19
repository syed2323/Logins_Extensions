//
//  facebook_login.swift
//  google login
//
//  Created by Syed Abdul Ahad on 3/12/22.
//

import  UIKit
import FBSDKLoginKit
import Firebase

//
class FacebookLoginHelper:UIViewController, LoginButtonDelegate {
   
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
