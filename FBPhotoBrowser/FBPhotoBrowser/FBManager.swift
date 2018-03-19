//
//  FBManager.swift
//  FBPhotoBrowser
//
//  Created by Maksym Bystryk on 3/14/18.
//  Copyright © 2018 max.bystryk.dev. All rights reserved.
//

import FBSDKLoginKit

class FBManager {
    
    //Login on Facebook
    static func login(viewController: UIViewController, completion: @escaping (_ result: String?) -> Void) {
        
        let params = ["email", "public_profile", "user_photos"]
        
        FBSDKLoginManager().logIn(withReadPermissions: params, from: viewController)
        { (result, err) in
            if err != nil {
                print ("FB Login failed: ", err as Any)
                completion("error")
                return
            }
            
            if result?.token == nil{
                print("Something wrong")
                completion("error")
            }
            else {
                print("Successfully Loged In")
                
                completion(result?.token.tokenString)
            }
        }
    }
    
    //Load avalable albums
    static func getAlbums(viewController: UIViewController, completion: @escaping (_ result: Any?) -> Void) {
        
        //Required parameters
        let params = ["fields" : "name, description, picture"]
        
        FBSDKGraphRequest(graphPath: "/me/albums", parameters: params).start {
            (connection, result, err) in
            
            if err != nil {
                print ("Something wrong!", err!)
                return
            }
            
            completion(result)
            
        }
    }
    
    //Load photos from albums
    static func getPhotosFromAlbum(viewController: UIViewController, albumId: String, completion: @escaping (_ result: Any?) -> Void) {
        
        let params = ["fields": "source"]
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "\(albumId)/photos", parameters: params )
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                print("Error: \(error!)")
            }
            else {
                completion(result)
            }
        })
    }
    
    static func isTokenAvailable() -> Bool {
        
        if FBSDKAccessToken.current() != nil {
            return true
        }
        
        return false
        
    }
    
    static func logOut() {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
    }
    
    
}
