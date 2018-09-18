//
//  FacebookLogin.swift
//  SocialEaseApp
//
//  Created by indianic on 26/06/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
import FBSDKLoginKit



class FacebookLogin: NSObject {

    typealias complitionHandler1 = (FBSDKGraphRequestConnection?, Any?, [String:String], Error?) -> Swift.Void
    
    func loginWithFB(vc:UIViewController,compliton:@escaping complitionHandler1)  {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: vc) { (result, error) -> Void in
        
            if (error == nil){
                if (result?.token != nil){
                    
                    FBSDKGraphRequest(graphPath:"me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                        var socialUserData:[String:String] = [:]
                        if (result != nil) {
                            
                            socialUserData["first_name"] = (result as AnyObject).value(forKey: "first_name") as? String ?? ""
                            socialUserData["last_name"] = (result as AnyObject).value(forKey: "last_name") as? String ?? ""
                            socialUserData["id"] = (result as AnyObject).value(forKey: "id") as? String ?? ""
                            socialUserData["email"] = (result as AnyObject).value(forKey: "email") as? String ?? ""
                            socialUserData["social_type"] = "fb"
                            socialUserData["profile_pic"] = String(format: "https://graph.facebook.com/%@/picture?type=large",socialUserData["id"]!)
                            print(socialUserData)
                            
                        }
                        
                        compliton(connection, result, socialUserData, error)

                    })
                }
            }
        }
    }
}
