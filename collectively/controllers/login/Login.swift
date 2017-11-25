//
//  Login.swift
//  collectively
//
//  Created by Łukasz Bożek on 28/09/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import PKHUD

class Login: UIViewController {
    
    @IBAction func facebookAction(_ sender: Any) {
         accessFB()
    }
    @IBAction func twitterAction(_ sender: Any) {
    }
    
    func accessFB() {
        let loginManager = FBSDKLoginManager()
        UIApplication.shared.statusBarStyle = .default  // remove this line if not required
        loginManager.logIn(withReadPermissions:["public_profile", "email"], from: self) { loginResult, error in
            if ((error) != nil) {
                // Process error
                let alert = UIAlertController(title: Msg.error, message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Msg.OK, style: .default))
                self.present(alert, animated: true, completion: nil)
            } else if loginResult!.isCancelled {
                // Handle cancellations
                print("canceled")
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if loginResult!.grantedPermissions.contains("email") {
                    // Do work
                    //                    print(loginResult!.token.tokenString) //YOUR FB TOKEN
                    print(loginResult!.token.tokenString)
                    self.makeFbAuth(token: loginResult!.token.tokenString)
                }
            }
            
        }
    }
    
    func makeFbAuth(token: String) {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,first_name,last_name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                let alert = UIAlertController(title: Msg.error, message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Msg.OK, style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                if let res = result as? [String: String] {
                    print(res)
                    HUD.show(.labeledSuccess(title: nil, subtitle: Msg.hello + "\n" + (res["first_name"] ?? "")))
                    HUD.hide(afterDelay: 3)
                    self.apiAuth(token: token)
                    return
                }
            }
        })
    }
    
    func apiAuth(token: String) {
        APIManager.auth.fb(token: token) { success in
            //kontynuacja
        }
    }
}
