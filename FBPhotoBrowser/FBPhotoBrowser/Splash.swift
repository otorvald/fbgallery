//
//  Splash.swift
//  FBPhotoBrowser
//
//  Created by Max Bystryk on 05.09.17.
//  Copyright © 2017 max.bystryk.dev. All rights reserved.
//

import UIKit

class Splash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerStart()
    }
    
    //Delay for the Splash Screen
    var timer = Timer()
    
    func timerStart(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Splash.checkToken), userInfo: nil, repeats: true)
    }
    
    //Checking whether the user is loged in
    @objc func checkToken() {
        
        if FBManager.isTokenAvailable() {
            self.showAlbums()
        }
        else {
            self.showLogin()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }

    //Show Login Screen or Albums Screen
    func showAlbums() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"MainNavigationController")
        dismiss(animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"LoginNavigationController")
        dismiss(animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }


}

