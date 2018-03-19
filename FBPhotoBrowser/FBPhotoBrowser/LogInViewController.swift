//
//  ViewController.swift
//  FBPhotoBrowser
//
//  Created by Max Bystryk on 05.09.17.
//  Copyright © 2017 max.bystryk.dev. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LogInViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    @IBAction func fbLoginButton(_ sender: Any) {
        
        FBManager.login(viewController: self) { (result) in
            if result != "error" {
                self.showAlbums()
            }
        }
        
    }
    
    func showAlbums() {
        performSegue(withIdentifier: "toAlbums", sender: self)
    }
    
}


